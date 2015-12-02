# Les formulaires en HTML

## Les éléments les plus courants

- on inclut les différents champs d'un formulaire dans un ancêtre `<form>`
- les éléments HTML les plus courants sont :
  - `<input>` pour les champs de saisie de texte en une ligne
  - `<textarea>` pour les champs de saisie de texte sur plusieurs lignes
  - `<select>` pour les choix multiples (on utilise `<option>` pour définir les choix)
- `<input>` accepte un attribut `type` qui définit son comportement (voir la [doc](https://developer.mozilla.org/fr/docs/Web/HTML/Element/Input) pour une liste exhaustive), les plus courants sont :
  - `text` : pour les textes sur une ligne
  - `password` : n'affiche pas la valeur
  - `checkbox` : pour définir des choix multiples
  - `radio` : pour définir des boutons radio (un seul choix possible contrairement aux `checkbox`)
  - `file` : pour sélectionner un fichier disponible sur la machine de l'utilisateur
  - `submit` : pour envoyer le formulaire
  - `hidden` : pour envoyer des champs supplémentaires au serveur, sans qu'ils soient affichés sur la page

Voilà quelques exemples :
```
// Les attributs "name", "placeholder"... sont expliqués plus bas
<input type="text" name="input" placeholder="Entrez du texte ici">
<input type="file" accept="image/*">
```

## Les labels

- à chaque champ (`<input>` ou `<texterea>` par exemple) on peut associer un `<label>` qui décrit le champ. De plus, si le `<label>` est cliqué par l'utilisateur, le navigateur donne le focus au champ concerné.
- il existe deux méthodes pour utiliser les labels, on en choisira une notamment en fonction du balisage souhaité pour la CSS :
```
// méthode 1 : le champ input est dans le label
<label>Nom<input type="text" name="name" /></label>
// méthode 2 : le champ input est référencé par son id
<label for="user-name">Nom</label>
<input type="text" id="user-name" name="name" />
```

## Nouveautés en HTML5

- des nouveaux types sur `<input>`, par exemple `number`, `email`, `tel`, `url`... Ils sont similaires à `text` mais le navigateur : vérifie que la valeur entrée a un format adéquat (et propose un clavier adapté à la saisie sur smartphone).
- `autofocus` possibilité de donner le focus à un champ (le curseur est actif dans ce champ quand la page vient de se charger)
- `required` pour dire si un champ est requis (il lui faut une valeur)
- `autocomplete` pour dire si le navigateur propose ou nom des valeurs connues (suivant les saisies précédentes de l'utilisateur)
- `maxlength`, `min`, `max`, `placeholder`... regarder la [doc](https://developer.mozilla.org/fr/docs/Web/HTML/Element/Input)

## Comment fonctionne l'envoi d'un formulaire ?

- c'est l'attribut `action` de `<form>` qui décide où est posté le contenu du formulaire. On peut le voir comme un équivalent du `href` de `<a>`
- par défaut si l'utilisateur tape sur "entrée", le formulaire va être envoyé, il est possible de changer ce comportement avec du JS
- il y a deux éléments qui permettent d'envoyer un formulaire s'ils sont cliqués :
```
// avec input, on indique le texte à afficher dans "value"
<input type="submit" value="Envoyer" />
// avec button, on peut inclure d'autres éléments HTML
<button type="submit">Envoyer</button>
<button type="submit"><img src="..." /></button>
```

## Qu'est ce qui est envoyé au serveur ?

Chaque champ d'un formulaire doit contenir un attribut `name` qui va permettre de structurer l'information envoyée au serveur.

Par exemple pour le formulaire suivant :
```
<form action="/register">
  <label for="id1">Prénom</label>
  <input type="text" name="firstname" id="id1" />
  <label for="id2">Email</label>
  <input type="text" name="email" id="id2" />
  <input type="submit" value="Envoyer" />
</form>
```
Si l'utilisateur renseigne comme prénom "Georges" et comme email "georges@beatles.com", il sera envoyé au serveur les infos suivantes :
```
firstname: Georges
email: georges@beatles.com
```
On voit donc :
- `id` est utile côté client/navigateur :
  - c'est la cible du label
  - mais sert toujours, comme déjà vu sur les autres éléments : à l'intégration CSS, ou comme #anchor dans une URL pour centrer la page sur l'élément donné
- `name` sert à l'envoi au serveur
- `id` et `name` sont complémentaires et n'ont pas connaissance l'un de l'autre

## Références

Un [guide](https://developer.mozilla.org/fr/docs/Web/Guide/HTML/Formulaires) par Mozilla Foundation et (en anglais) [styler vos formulaires](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Forms/Advanced_styling_for_HTML_forms) grâce à CSS3
