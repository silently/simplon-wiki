# Analogie Javascript et langue française

### Grammaire

Des éléments de la grammaire française traduits en JS :
- ponctuation `, ; ( ) { }`
- logique et conjonctions de subordination ~ contrôle `if else switch while for`
- nom : données/valeurs `1 "un" [1] { prop: 1} function() {}`
- pronom (prend la place d'un nom) `var`
- il y a des mots "invariables" `true false`
- verbes : opérateurs, fonctions et méthodes

### Champ lexical

Si on admet l'analogie "nom en français" <=> "données en JS", on peut comparer le champ lexical au type de données :
- données de type primitif :
  - booléens `true false` (espace de valeurs invariable)
  - nombres `1 1.1 1e4`
  - chaînes de caractères `"aujourd'hui"` ou `'aujourd\'hui'`
  - symbols
  - valeur nulle `null`
  - valeur non définie `undefined`
- les objets
  - objet générique `{ propriété: "valeur", autre: 2 }`
  - tableaux `[1, 2, 3]`
  - plus tous les types qu'on veut créer, ceux d'ES6 (Map, Set)...
- les fonctions (et oui un verbe peut servir de nom "tricher n'est pas jouer")

TODO portée des variables

### Les verbes en actions

```
// operator
var result = x + y;
// invocation de fonction
result = add(x, y);
// invocation de méthode
result = x.add(y);
```

Quelques opérateurs .[]() typeof = + - ! * / % > < <= >= !== === && || ? : ++ --  new += return ? :

### Orthographe JS

- un nom de variable est une lettre optionnellement suivie par une ou plusieurs lettres, chiffres et _
- il existe des mots réservés par le langage, et donc interdits dans le noms de variables `if function else var`...
- les valeurs littérales :
  - pour un nombre  `10 2.5 3.1e2`
  - une chaîne de caractère
  - un tableau (array) `[1, 2, 3]`
  - un objet
  - une fonction `function myFunction(arguments) { "body"; }`
  - une expression régulière `/ab+c/`

### Conjugaison JS

Les différentes manières d'enclencher les actions/verbes (invocation, apply, call)

### Vocabulaire JS

Mots du langage, et API, à savoir objets et fonctions déjà présents, par exemple :
- `parseInt`
- `isNaN`
- `true`
- `window` dans un navigateur
- `console`
- `JSON.parse()`
