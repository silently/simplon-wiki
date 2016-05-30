# Installation phonegap avec une cible Android

TODO mtpfs + PATH (voir google docs)

Installer une version récente de node.js (>= 4)

Mettre à jour npm

```$ sudo npm install -g cordova```

```$ sudo npm install -g ionic```

```$ sudo apt-get install default-jdk```

Installer le studio Android, voir la [documentation](http://developer.android.com/sdk/installing/index.html?pkg=studio)

Régler éventuellement JAVA_HOME et ANDROID_HOME suivant où ce sont installés le default-jdk et android Studio

Normalement on a maintenant un utilitaire “adb”. En ligne de commande, si votre téléphone est branché (et
mode développeur activé), si on fait :

```$ adb devices```

→ il doit être listé (on voit un identifiant unique)
→ sinon voir [ce sujet]( http://askubuntu.com/questions/632651/adb-devices-command-wont-detect-my-4-4-android-phone)

Et donc pour vérifier que tout a marché et lancer un projet phonegap via ionic, aller dans son répertoire projets et faire :

```
$ ionic start iotest blank
$ cd iotest
$ ionic platform add android
$ ionic run android
```
