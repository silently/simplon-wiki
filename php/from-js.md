# Intro PHP

Pour ceux qui viennent de JavaScript.

## Similitudes

Comme JavaScript, PHP :
- est un langage de script, dynamique et interprété
- repose sur une spécification (le comportement attendu du langage) et différentes implémentations (interpréteurs qui peuvent exécuter des sources en PHP)
- a une syntaxe héritée du langage C (avec des blocs {}, des fonctions...)
- repose sur des expressions, opérateurs, instructions...
- est orienté objet (avec un modèle objet/classe plus classique et répandu que les prototypes en JS)
- permet de noter des valeurs littérales (valeurs "brutes") :
  - `true` `false` pour le type `boolean`
  - `123` `0` `-123` pour le type `integer`
  - `1.234` `1.2e3`  pour le type `float`
  - `'chaîne de caractères'` pour le type `string`
  - `[1, 2, 3, 4]` pour le type `array`
  - mais il n'y a pas de notation littérale pour les objets en PHP (en JS on peut directement écrire `var obj = { prop1: 'val1', prop2: val2 };`)
- propose un `===` plus strict que `==` (le comportement n'est pas identique à JS)
- est sensible à la casse pour les noms de variables (mais attention bizarrerie : PHP est insensible à la casse pour classes et functions !)

## Petit traducteur au quotidien

A compléter !

| | JS | PHP |
| --- | --- | --- |
| gestionnaire de dépendances | npm | compose |
| lancer un interpréteur interactif depuis le terminal | `$ node`  | `$ php -a` |
| serveur HTTP en environnement de développement | `$ node app.js` où app.js implémente le serveur | `$ php -S localhost:8000` (regarder la doc pour voir toutes les options) |
| serveur HTTP en environnement de production | `$ node app.js` derrière (facultatif) un nginx ou Apache | nginx ou Apache en front obligatoire, pour des raisons de performance |
| début d'un fichier source | rien | `<?php` sur la première ligne |
| fin d'un fichier source | rien | rien (bonne pratique) |
| fin d'une instruction | `;` recommandé | `;` obligatoire |
| déclaration et assignation de variable | `var x = 0;` | `$x = 0;` |
| afficher le contenu d'une variable | `console.log` | `var_dump` |
| concaténation de caractères | `+` | `.` |
| commentaires | `//` `/* */` | `//` `/* */` `#` |
| tout ce qui est faux | `false` `0` `""` `NaN` `null` `undefined` | `false` `0` `0.0` `""` `"0"` `NULL` empty arrays and objects |
| nom des variables | commence par `_` `$` ou une lettre (minuscule ou majuscule). Peuvent suivre ces mêmes caractères ainsi que des chiffres | même règle mais le nom de variable est **toujours** préfixé par un `$` |
| destruction d'une variable | `delete x;` | `unset($x);` |
| constantes | `const one = 1;` | `define('ONE', 1);` |
| conversion en entier | `var i = parseInt(22/3);` | `$i = (int) (22/3);`

## Différences notables

### Environnement d'exécution

PHP est un langage pensé à son origine pour le traitement des requêtes HTTP, raison pour laquelle des variables globales décrivant la requête HTTP en cours sont définies. Plus généralements, PHP est un langage de script qui peut s'exécuter sur différents systèmes d'exploitation et architectures...

...mais n'oublions pas que JavaScript est seul à s'exécuter à la fois côté serveur (Node.JS) et côté client (dans l'interpréteur du navigateur).

### Les types en PHP

PHP définit 4 types scalaires (scalar en anglais, comprendre types "bruts"):
- `boolean`
- `integer`
- `float`
- `string`

Il existe ensuite deux types dits composés (compound en anglais) et déjà discutés :
- `array`
- `object`

Le modèle objet offre une API au travers de classes à instancier, par exemple `DateTime`.

Enfin, deux types spéciaux :
- `resource` (pour se lier à une ressource externe, par exemple une base de donnée)
- `NULL` dont la seule valeur est `NULL` et signifiant *pas de valeur*

Il est possible de tester le type d'une variable ou d'une valeur avec les fonctions `is_bool`, `is_int`, `is_float`, `is_string`, `is_array`, `is_object`, `is_resource`, `is_null`.

### Rappel : les types en JS

JS définit 6 types primitifs :
- `boolean`
- `null`
- `undefined` (pas d'équivalent en PHP)
- `number` (divisé en deux types différents en PHP, les nombres entiers et flottants)
- `string`
- `symbol` (depuis ECMAScript 6)

Les valeurs non primitives sont globalement regroupées sous la notion d'objet : bien entendu les objets (constructeur `Object`), tableaux (constructeur `Array`), expressions régulières (constructeur `RegExp`), fonctions (constructeur `Function`), dates (constructeur `Date`)...

Pour tous ces types (sauf pour les fonctions), `typeof` renverra `object`. Pour certains d'entre eux il est plus fréquent d'utiliser la notation littérale que l'instanciation :

En effet `var arr = [1, 2, 3];` est plus fréquent que : `var arr = new Array(1, 2, 3);`

### Objets, tableaux, tableaux associatifs

**En JS**, l'implémentation des objets repose sur les tableaux associatifs, un type abstrait qui associe des clefs à des valeurs. On parle aussi de collections de propriétés (une propriété = une clef + une valeur).

On peut donc directement définir un objet depuis une valeur littérale : `var obj = { prop1: 'val1', prop2: val2 };`. Même si on préfère une instantiation depuis un constructeur `var obj = new MyClass();` l'objet aura toujours la forme d'un tableau associatif (dont les clefs/valeurs sont initialisées par `MyClass`).

Toujours en JavaScript, un tableau `var arr = ["abc", 2];` est similaire à un tableau associatif dont les clefs sont les index, par exemple la valeur `"abc"` est associée à la clef `0` (index 0 du tableau).

**Pour résumer en JS** : objets, tableaux et tableaux associatifs reposent sur une même implémentation (celle des tableaux associatifs). C'est pourquoi on peut utiliser les mêmes opérateurs de raffinement (`.` et `[]`) sur chacun d'entre eux.

**En PHP**, il existe deux types *composés* (voir ci-dessus) : les tableaux et les objets.

Le type tableau permet autant de créer un tableau simple `$a = [1, 2, 3, 4];` qu'un tableau associatif  `$a = ["prop1" => "val1", "prop2" => "val2"];`.

Le type objet nécessite qu'une classe (ici `Foo`) soit définie `$bar = new Foo();`.

**En résumé pour PHP** : objets et tableaux sont deux types différents, il ne faut notamment pas confondre objets et tableaux associatifs. C'est pourquoi les opérateurs de raffinement ne sont pas les mêmes : `$a[]` pour un tableau, `$o->prop` pour un objet.

### Les chaînes de caractères en PHP

Les guillemets simples et doubles n'ont pas le même effet en PHP :

```php
$fruit = 'abricot';

echo "Avec quelques \$, j'ai acheté un $fruit";
// Affiche : Avec quelques $, j'ai acheté un abricot

echo 'Avec quelques $, j\'ai acheté un $fruit';
// Affiche : Avec quelques $, j'ai acheté un $fruit
```

Entre guillemets doubles la chaîne est **interpolée** (la variable $fruit est remplacée par la valeur abricot) et **interprétée** (les séquences spéciales commençant par `\` sont modifiées, il en existe une dizaine).

Entre guillemets simples la chaîne de caractère n'est **pas** interpolée, et les seules séquences spéciales qui sont interprétées sont `\'` (transformé en `'`) et `\\` (transformé en `\`).

### Rappel : les chaînes de caractères en JS

En JS, contrairement au PHP, guillemets simples **et** doubles procèdent toujours à l'interprétation des séquences spéciales (commençant par un `\`) et jamais à une interpolation des variables. Ils ont donc un effet similaire.

ECMAScript 6 a cependant introduit une nouvelle notation avec les accents graves (backticks) qui permet l'interpolation des variables : `` `valeur de ma ${variable}` ``

### Les + du langage PHP

**Modèle objet** avec définition de classe plus classique.

**La réduction des conflits de nommage** grâce à :
- un modèle plus strict de portée des variables (une variable définie dans une fonction n'est jamais visible à l'extérieur, et l'intérieur d'une fonction ne voit pas par défaut son contexte extérieur).
- aux namespaces (deux variables ayant le même nom mais appartenant à des namespaces différents n'entrent pas en conflit). En effet les variables définies dans un namespace donné ne sont **pas** globales.

Il existe cependant des cas où il est intéressant d'utiliser le contexte extérieur dans une fonction, il faut alors être **explicite** (alors qu'en JS on peut implicitement accéder au monde extérieur).

Pour une variable globale (utiliser `global`) :

```php
$a = 1;
function sumA($x) {
  global $a;
  return $a + $x;
}
```

Dans un namespace (ici `$name` n'est **pas** globale), utiliser `use` :

Premier fichier :
```php
<?php
namespace MonEspace;

$name = "MonEspace";

function welcome() use ($name) {
  return "Bienvenue de la part de " . $name;
}
```

Second fichier :
```php
<?php
use MonEspace;

echo welcome();
```

## Quelques spécificités de PHP

Il existe des variables statiques qui, définies à l'intérieur d'une fonction, gardent leur valeur entre deux appels.

A compléter...

## Un exemple dans les 2 langages

En PHP :
```php
function convertUpper($names) {
  for($i = 0; $i < count($names); $i++) {
    $names[$i] = strtoupper($names[$i]);
  }
  return $names;
}
$names = ['michael', 'john', 'samantha'];
$names = convertUpper($names);
```

En JavaScript :
```javascript
function convertUpper(names)  {
  for(var i = 0; i < names.length; i++) {
    names[i] = names[i].toUpperCase();
  }
  return names;
}
var names = { ‘michael’, ‘john’, ‘samantha’ };
names = convertUpper(names);
```
