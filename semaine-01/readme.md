# Programme semaine 10

## CSS

Exercices faits en cours : https://github.com/silently/ex-01-css

Une intro aux sélécteurs http://iamvdo.me/blog/ce-que-vous-avez-toujours-voulu-savoir-sur-css

D'autres exemples sur les sélecteurs http://code.tutsplus.com/tutorials/the-30-css-selectors-you-must-memorize--net-16048

La liste de fonctionnalités CSS3 en anglais http://www.htmlgoodies.com/html5/css/whats-new-in-css3.html#fbid=X5yEvhtSq_j

Un résumé en français http://gafish.fr/nouveautes-css3/

Est-ce que je peux utiliser ces fonctionnalités ? http://caniuse.com/


## Intro Javascript

### La grammaire JS

- ponctuation `, ; ( ) { } ? :`
- conjonctions de subordination `if else switch while for`
- pronom `var`
- groupe nominal : valeurs littérales `1 "un" [1] { prop: 1} function() {}`
- il y a des mots "invariables" `true false`
- verbes :
  - opérateurs .[]() typeof = + - ! * / % > < <= >= !== === && || ? : ++ --  new += return
  - fonctions
  - méthodes

Exemples d'utilisation des verbes :
```
// operator
var result = x + y;
// function
result = add(x, y);
// method
result = x.add(y);

### Orthographe JS

- un nom de variable est une lettre optionnellement suivie par une ou plusieurs lettres, chiffres et _
- il existe des mots réservés par le langage, et donc interdits dans le noms de variables `if function else var`...
- les valeurs littérales :
  - pour un nombre  `3.1e2`
  - une chaîne de caractère `"aujourd'hui"` ou `'aujourd\'hui'`
  - un tableau (array) `[]`
  - un objet `{ propriété: "valeur", autre: 2 }`
  - une fonction `function(arguments) { "body"; }`
  - une expression régulière `/ab+c/`

### Conjugaison JS

Les différentes manières d'enclencher les actions/verbes

### Vocabulaire JS

Mots du langage, et API, à savoir objets et fonctions déjà présents, par exemple :
- `parseInt`
- `isNaN`
- `true`
- `window` dans un navigateur
- `console`
- `JSON.parse()`
