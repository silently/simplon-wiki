# Recherche fulltext en SQL

... ou quelques utilisations de WHERE LIKE et WHERE MATCH AGAINST

Pour commencer, récupérer le fichier de données :
https://github.com/silently/simplon-wiki/raw/master/assets/data-people.sql.gz

Et le mettre dans un répertoire “fulltext” créé pour l’occasion

Ci-dessous `$` indique une ligne de commande linux et `>` désigne la console mysql.

## Prise en main

```
$ cd fulltext
$ gzip -d data-people.sql
$ mysql -u root -p
```

Remarque : on a ouvert une session mysql avec le user root car on videra le `query cache` (expliqué un peu plus loin).

```
> SHOW DATABASES;
> SHOW ENGINES;
> USE fulltext;
> CREATE TABLE `people` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `firstname` varchar(255) default NULL,
  `surname` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `bestfriend` varchar(255) default NULL,
  `biography` TEXT default NULL,
  PRIMARY KEY (`id`)
) AUTO_INCREMENT=1;
> SHOW TABLES;
> SHOW COLUMNS FROM people;
```

On insère les données dans la table et on lance quelques SELECT

```
> source data-people.sql;
> SELECT count(*) FROM people;
> SHOW INDEX FROM fulltext.people;
> SELECT * FROM people LIMIT 1;
> SELECT firstname, surname, email FROM people LIMIT 1;
> SELECT firstname, surname, email FROM people LIMIT 5;
> SELECT firstname, surname, email FROM people ORDER BY email LIMIT 5;
> SELECT firstname, surname, email FROM people ORDER BY email ASC LIMIT 5;
> SELECT firstname, surname, email FROM people ORDER BY email DESC LIMIT 5;
```

## Recherches sur un champ VARCHAR

Première recherce avec WHERE

```
> SELECT id, firstname, surname FROM people WHERE firstname = "Colby" LIMIT 1;
```

Et maintenant une opération coûteuse (plus d'une seconde !) car tout le contenu de la base doit être inspecté.

```
> SELECT COUNT(*) FROM people WHERE surname = "Wong";
+----------+
| COUNT(*) |
+----------+
|       95 |
+----------+
1 row in set (1.06 sec)
```

La mise en cache des résultats donne un temps instantané

```
> SELECT COUNT(*) FROM people WHERE surname = "Wong";
+----------+
| COUNT(*) |
+----------+
|       95 |
+----------+
1 row in set (0.00 sec)
```

Mais si on vide le cache...

```
> reset query cache;
Query OK, 0 rows affected (0.00 sec)
> SELECT COUNT(*) FROM people WHERE surname = "Wong";
+----------+
| COUNT(*) |
+----------+
|       95 |
+----------+
1 row in set (1.08 sec)
```

On voit de nouveau un temps supérieur à une seconde (sur ma machine).

Si on veut avoir des détails sur cette requête, on demande une explication (on peut ajouter EXPLAIN avant n'importe quelle requête, elle ne sera pas exécutée mais MySQL nous explique ce qu'il a à disposition pour le faire)

```
> EXPLAIN SELECT COUNT(*) FROM people WHERE surname = "Wong";
+----+-------------+--------+------+---------------+------+---------+------+-------+-------------+
| id | select_type | table  | type | possible_keys | key  | key_len | ref  | rows  | Extra       |
+----+-------------+--------+------+---------------+------+---------+------+-------+-------------+
|  1 | SIMPLE      | people | ALL  | NULL          | NULL | NULL    | NULL | 92226 | Using where |
+----+-------------+--------+------+---------------+------+---------+------+-------+-------------+
1 row in set (0.00 sec)
```

Ici, on voit qu'un index sur surname serait bien venu.

```
> CREATE INDEX surname_index on people (surname);
Query OK, 0 rows affected (1.23 sec)
Records: 0  Duplicates: 0  Warnings: 0

> EXPLAIN SELECT COUNT(*) FROM people WHERE surname = "Wong";
+----+-------------+--------+------+---------------+---------------+---------+-------+------+--------------------------+
| id | select_type | table  | type | possible_keys | key           | key_len | ref   | rows | Extra                    |
+----+-------------+--------+------+---------------+---------------+---------+-------+------+--------------------------+
|  1 | SIMPLE      | people | ref  | surname_index | surname_index | 258     | const |   95 | Using where; Using index |
+----+-------------+--------+------+---------------+---------------+---------+-------+------+--------------------------+
1 row in set (0.00 sec)
```

Désormais EXPLAIN nous indique qu'il va pouvoir utiliser l'index, et donc si on relance la requête, c'est bien plus rapide.

```
> reset query cache;
Query OK, 0 rows affected (0.00 sec)
> SELECT COUNT(*) FROM people WHERE surname = "Wong";
+----------+
| COUNT(*) |
+----------+
|       95 |
+----------+
1 row in set (0.00 sec)
```

Lançons désormais une recherche sur les emails qui ne sont pas indexés :

```
> SELECT id, firstname, surname FROM people WHERE email = "amet@auctor.ca" LIMIT 1;
+----+-----------+---------+
| id | firstname | surname |
+----+-----------+---------+
|  3 | Patience  | Lynch   |
+----+-----------+---------+
1 row in set (0.00 sec)

> SELECT id, firstname, surname FROM people WHERE email = "a@Nullaeuneque.edu" LIMIT 1;
+--------+-----------+---------+
| id     | firstname | surname |
+--------+-----------+---------+
| 100000 | Alexa     | Gould   |
+--------+-----------+---------+
1 row in set (1.07 sec)
```

La première requête est effectuée beaucoup plus rapidement (satisfaite pour l'id 3) que la seconde qui n'a été satisfaite que pour la dernière ligne de la table (et donc il aura fallu parcourir tout la table)... Ce qu'on va améliorer en créant un index.

```
> CREATE INDEX email_index on people (email);

> reset query cache;

> SELECT id, firstname, surname FROM people WHERE email = "amet@auctor.ca" LIMIT 1;
+----+-----------+---------+
| id | firstname | surname |
+----+-----------+---------+
|  3 | Patience  | Lynch   |
+----+-----------+---------+
1 row in set (0.00 sec)

> SELECT id, firstname, surname FROM people WHERE email = "a@Nullaeuneque.edu" LIMIT 1;
+--------+-----------+---------+
| id     | firstname | surname |
+--------+-----------+---------+
| 100000 | Alexa     | Gould   |
+--------+-----------+---------+
1 row in set (0.00 sec)
```

On peut lister les index crééés jusqu'à présent :

```
> SHOW INDEX FROM fulltext.people;
```

On peut aussi faire des recherches sur une partie d'une chaîne de caractère

```
> SELECT COUNT(*) FROM people WHERE surname LIKE "W%";
+----------+
| COUNT(*) |
+----------+
|     6283 |
+----------+
1 row in set (0.00 sec)

>  SELECT COUNT(*) FROM people WHERE surname LIKE  "%W";
+----------+
| COUNT(*) |
+----------+
|      504 |
+----------+
1 row in set (0.02 sec)
```

La seconde requête est un peu plus lente car les index partent de la gauche.

## Recherches sur un champ TEXT

Un champ TEXT peut contenir des chaînes de caractères plus longues (voir le [cours openclassroom sur les types de données MySQL](https://openclassrooms.com/courses/administrez-vos-bases-de-donnees-avec-mysql/les-types-de-donnees)).

```
> CREATE INDEX biography_index on people (biography);
ERROR 1170 (42000): BLOB/TEXT column 'biography' used in key specification without a key length
```

MySQL refuse de créer cet index si on ne spécifie pas combien de caractères on veut indexer. Donc on pourrait faire :

```
> CREATE INDEX biography_index on people (biography(100));
Query OK, 0 rows affected (1.44 sec)
```

Mais donc seuls les 100 premiers caractères seront pris en compte. Il est temps de passer à un index [FULLTEXT](https://openclassrooms.com/courses/administrez-vos-bases-de-donnees-avec-mysql/index-1) et pour cela il faut utiliser le moteur [MYISAM](https://openclassrooms.com/courses/les-moteurs-de-stockage-de-mysql-2). Avec ce moteur on pourra chercher n'importe quel mot dans la colonne biography.

```
> ALTER TABLE  `people` ENGINE = MYISAM ;
```

Et on créé un index FULLTEXT (ça prend du temps) :

```
> CREATE FULLTEXT INDEX index_biography ON people (biography);
Query OK, 100000 rows affected (37.20 sec)
Records: 100000  Duplicates: 0  Warnings: 0
```

On peut désormais utiliser MATCH AGAINST

```
> SELECT COUNT(*) FROM people WHERE MATCH (biography) against ('aliquam' IN BOOLEAN MODE);
+----------+
| COUNT(*) |
+----------+
|    96749 |
+----------+
1 row in set (0.23 sec)
```

Si on omet IN BOOLEAN MODE, on est implicitement IN NATURAL LANGUAGE MODE et là, attention :

```
> SELECT COUNT(*) FROM people WHERE MATCH (biography) against ('aliquam' IN NATURAL LANGUAGE MODE);
+----------+
| COUNT(*) |
+----------+
|        0 |
+----------+
1 row in set (0.10 sec)
```

On a ici aucun résultat car `aliquam` est tellement courant (96749 occurences) que le moteur ne le considère pas comme pertinent et ne l'indexe pas.

Le BOOLEAN MODE permet de faire des recherches excluant telle chaîne de caractère, ou commençant par certaines lettres (wildcard *, contrairement au % de WHERE LIKE) :

```
> SELECT COUNT(*) FROM people WHERE MATCH (biography) against ('lor*' IN BOOLEAN MODE);+----------+
| COUNT(*) |
+----------+
|    98155 |
+----------+
1 row in set (0.25 sec)
```

Pour étudier les différences entre NATURAL LANGUAGE et BOOLEAN modes, voir par exemple le [cours](https://openclassrooms.com/courses/administrez-vos-bases-de-donnees-avec-mysql/index-1) openclassroom.

Pour finir, il est possible de créer des index FULLTEXT sur plusieurs colonnes, et donc de lancer des recherches sur ces plusieurs colonnes en une requête :

```
> CREATE FULLTEXT INDEX index_full_best_bio ON people (bestfriend, biography);Query OK, 100000 rows affected (1 min 18.10 sec)
Records: 100000  Duplicates: 0  Warnings: 0

> SELECT COUNT(*) FROM people WHERE MATCH (bestfriend, biography) against ('Wh*' IN BOOLEAN MODE);
+----------+
| COUNT(*) |
+----------+
|      937 |
+----------+
1 row in set (0.01 sec)

> quit;
```

```
$ gzip data-people.sql.gz
```

Ou alors on supprime le fichier.
