# SupraVim 3.2.4

Un éditeur de texte Vim pour 42 d'Angoulême.

<img src="img/readme.png"/>

## Installation:

```bash
curl https://gitlab.com/hydrasho/SupraVim/-/raw/master/installer.sh | sh
```
**Dépendances**

| Zsh | Clang | Vim 8 |
|-----|-------|-------|

## Mise à jour:
```bash
    supravim update
```



## Désinstallation

```bash
    supravim uninstall
```
## Utilisation

| Nom | Raccourcis |
| ------ | ------ |
| Fermer une fenêtre | Ctrl + Q |
| Sauvegarde une fênetre | Ctrl + S|
| TOUT Sauvegarder | :wall|
| TOUT Quitter | :qall|
| HEADER 42| **F1**|
| Norminette | **F3**|
| Compilation | **F5**|
| Debogueur | **Ctrl + F5**|
| Deplacement | Shift - flèche|
| Fermer/Ouvrir la fenêtre de l'arbre | Ctrl +G |
| Scinder la fenêtre horizontalement | Ctrl + D|
| Scinder la fenêtre verticalement | Shift + D|
| Créer un nouvel onglet | Ctrl + N|
| Déplacement entre les onglets | Ctrl + Flèche|
| Ouvrir un terminal | Shift - T|

# Compilation

Si votre projet contient un fichier Makefile, vous pourrez compiler votre programme avec la touche F5, celui-ci le détectera et exécutera la règle ALL suivie de la règle RUN.

Dans le cas contraire, il compilera tous les fichiers C présents ensemble et exécutera le a.out généré.

# Débogage

Le débogage s'effectue avec CTRL-F5.
N'oubliez pas de compiler avec les flags `-g` ou `-g3 -Og` pour obtenir des informations plus approfondies.

Si votre programme est lancé via un makefile, Vim ne trouvera pas votre exécutable, il faudra le fournir à gdb avec `file monexe`.

<img src="img/GDB.png"/>

Vous pouvez également quitter le mode avec Ctrl+Q tout comme le terminal.

# HEADER

Supravim vous permet aussi d'inclure les prototypes de vos fichiers C dans votre fichier header en utilisant la commande `:MakeHeader`.
Exemple: `:MakeHeader hello.c foo.c bar.c` écrira les prototypes de ces fichiers en dessous de votre curseur vim.
Note: Vous pouvez utiliser l'opérateur `*` ->  `*.c` | `xxx*.c`.

<img src="img/header.gif"/>

# SNIPPET

Les snippets permettent d'écrire du code pré-enregistré pour augmenter sa vitesse de code.

| SNIPPET | Fonction |
| ------ | ------ |
| ifndef| IFNDEF de 42|
| mainv| un main void|
| main | un main vide avec argc,argv|
| mainh|  un main avec tous les headers pour déboguer rapidement|
| while| boucle while |
| if| condition if |
| elif | condition else if |
| inc ou include| #include <name.h>|
| func| débute l'écriture d'une fonction |
| funcd| identique mais uniquement pour un prototype |
| for| boucle for |
| tstruct ou struct| une structure avec typedef ou simple |

<img src="img/Snipets.gif"/>

# Programme Supravim
Le programme Supravim s'utilise dans le terminal avec la commande `supravim`.
Il permet d'activer des options, de les désactiver, de changer son thème, de le mettre à jour ou de le désinstaller.
Vous pouvez également utiliser `supravim switch` pour passer d'une session Supravim à Vim et inversement.

<img src="img/theme-binary.gif"/>

# CHANGELOG
# Nouveautés de la 2.0

- Support des onglets.
- Ajout de l'intégration GDB.
- UNDO infini! (se sauvegarde même après la fermeture).
- Générateur de prototype pour les headers C.
- Commenter et décommenter en selectionnant une ou plusieurs lignes.
- Création d'un mini logiciel Supravim (`supravim -h` pour plus de détails).
    * Personnaliser le thème de Vim et les options.
    * Désinstaller ou mettre à jour Supravim.

# Nouveautés de la 3.0

- Beaucoup de corrections de bugs !
- GDB (CTRL+F5) compile avant de se lancer.
- Un installateur plus propre.
- Les configurations sont enregistrées après les mises à jour.
- Un espace dédié dans le vimrc qui ne sera pas effacé lors des mises à jour.
- Une intégration aux CTAGS.
- Pouvoir quitter les terminaux ou le GDB avec CTRL+Q ou s'en deplacer.
- SNIPPETS intelligents et complets.
- F3-F5 efface désormais l'écran pour ne pas saccader l'affichage.
- De nouvelles options et une autocomplétion dans le programme.
- De nouveaux thèmes (onedark|half|light / atom / iceberg).
- Une meilleure integration de thèmes et des icônes activables.
