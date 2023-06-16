# SupraVim 4.2

Un éditeur de texte Vim pour 42 d'Angoulême.

Il contient : supramake supratags suprabrain supracom supranorme
MP moi sur le discord/slack de 42 si besoin (nda-cunh)

# note

N'hésitez pas à découvrir d'autre éditeur de texte, ou d'ide ou de construire votre propre configuration VIM la seule limite et votre pensée. savoir configurer ses outils , c'est aussi être plus à l'aise avec votre travail.

<img src="img/readme.png"/>


## Installation:

branche principal:
```bash
curl https://gitlab.com/hydrasho/SupraVim/-/raw/master/installer.sh | sh
```

branche dev:
```bash
curl https://gitlab.com/hydrasho/SupraVim/-/raw/dev/installer_dev.sh | sh
```

**Dépendances**

| Zsh | Clang | Vim 8 | Vala |
|-----|-------|-------|------|

# Beta suprabrain

Suprabrain une IA pour supravim , demandez lui de l'aide pour supravim !

## Mise à jour:
```bash
    supravim update
```

ou

```bash
    supravim update dev
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
| TOUT Sauvegarder | :wall ou :wa|
| TOUT Quitter | :qall ou :qa|
| HEADER 42| **F1**|
| Switch SupraNorm | **F3**|
| Compilation | **F5**|
| Debogueur (GDB) | **Ctrl + F5**|
| Commenter | cc (fonctionne aussi en visuel) |
| Deplacement entre fênetre | Shift - flèche|
| Fermer/Ouvrir l'arbre des répértoires | Ctrl +G |
| Scinder la fenêtre horizontalement | Ctrl + D|
| Scinder la fenêtre verticalement | Shift + D|
| Créer un nouvel onglet | Ctrl + N|
| Déplacement entre les onglets | Ctrl + Flèche|
| Ouvrir un terminal | Shift - T|
| Ctrl+R | le contraire du Undo.. le Redo|
| ------ | ------ |
| Ctr+ Up | Aller sur la fonction sous le curseur|
| Ctr+ Down |Retourner sur la fonction d'avant|

# Compilation (SupraMake)

<img src="img/makeclean.png"/>

la commande ``:Make`` permet d'executer une règle de votre makefile (il se chargera de retrouvé le makefile lié  à votre projet.)
``:Make clean`` lancera la regle clean et ainsi de suite...

Si votre projet contient un fichier Makefile, vous pourrez compiler votre programme avec la touche F5, celui-ci le détectera et exécutera la règle RUN. (mettez all en dependance pour que run compile votre projet avant).

Dans le cas contraire, il compilera tous les fichiers C présents ensemble et exécutera le a.out généré.

note: F6 et F7 lance eux la règle run2 et run3 du makefile si elles existent.

exemple d'un makefile:
```make
NAME=hello

all:
    gcc main.c -o $(NAME)

run: all
    ./$(NAME)
```

## SupraMake

supramake est une commande de supravim (c'est celui-ci qu'il utilise pour le F5,6,7)
il fonctionne comme la commande make, sauf qu'il cherchera ou se trouve le makefile pour executer votre règle.

si vous êtes ici:
``~/Desktop/Projets/src/folder1/folder2/``
et que votre Makefile est ici:
``~/Desktop/Projets/Makefile``

``supramake rule`` le lancera, tandis que ``make rule`` ne le trouvera pas.

il est possible d'ajouter des arguments a executer pour run avec la variable
$(ARG) avec la commande

supramake run --arg \<vos argument\>

# Entrer dans une fonction

vous pouvez aller directement a une fonction ou define en question en faisant la touche 'Ctrl + UP' sur le symbole, il vous ouvrira le fichier et l'emplacement de l'initiation de ce symbole.
Ctrl+Down retournera en arrière.

Fonctionne avec les structures, defines et fonction.

# Débogage

Le débogage s'effectue avec CTRL-F5.
N'oubliez pas de compiler avec les flags `-g` ou `-g3` pour obtenir des informations plus approfondies.

Si votre programme est lancé via un makefile, Vim ne trouvera pas votre exécutable, il faudra le fournir à gdb avec `file monexe`.

<img src="img/GDB.png"/>

Vous pouvez également quitter le mode avec Ctrl+Q tout comme le terminal.

# HEADER

Supravim vous permet aussi d'inclure les prototypes de vos fichiers C dans votre fichier header en utilisant la commande `:MakeHeader`.
Exemple: `:MakeHeader hello.c foo.c bar.c` écrira les prototypes de ces fichiers en dessous de votre curseur vim.
Note: Vous pouvez utiliser l'opérateur `*` ->  `*.c` | `xxx*.c`.

<img src="img/header.gif"/>

# Programme Supravim
Le programme Supravim s'utilise dans le terminal avec la commande `supravim`.
Il permet d'activer des options, de les désactiver, de changer son thème, de le mettre à jour ou de le désinstaller.
Vous pouvez également utiliser `supravim switch` pour passer d'une session Supravim à Vim et inversement.

`supravim --theme onedark` pour passer au theme onedark  (gruvbox) est par default.

Listes des themes:
``atom, gruvbox, molokai, onehalf, pablo, Tomorrow-Night-Eighties, dracula, iceberg, onedark, onelight, Tomorrow-Night``~~~~
<img src="img/theme-binary.gif"/>

n'hésitez pas à regarder ``supravim --status`` pour voir les options activé ou désactivé par default.

vous pourrez les activé avec ``supravime --enable option``
exemple:  ``supravim --enable icons``
activera la prise en charge d'icone.

exemple:  ``supravim --disable tree``
retirera l'arbre de dossier à gauche par défault.


# Tu veux le customisé un peu plus ?


<img src="img/yourconfig.png"/>

Tu peux ajouter tes propres lignes de vim dans cette balise, à chaque mise à jour la balise sera conservé et jamais écrasé.

# Vous faites une autre langue que C, C++, Vala ?

il suffit de faire ``:LspInstallServer <optionel: non dun server>``

la listes des serveur est ici https://github.com/mattn/vim-lsp-settings#supported-languages


je recommande egalement d'ajouter dans votre balise YourConfig:
```
if expand('%:e') == '.py'                     
    var lsp_diagnostics_enabled = 1
	g:lsp_diagnostics_signs_priority = 1
	g:lsp_diagnostics_signs_insert_mode_enabled = 1
    g:lsp_diagnostics_signs_enabled = 1
endif                                       
```
remplacer .py par l'extension de votre fichier
## Python
pour un support python:

```
//dans vim:
 :LspInstallServer

//dans votre .vimrc a la fin dans YOUR CONFIG:

if expand('%:e') == '.py'                     
    var lsp_diagnostics_enabled = 1
    g:lsp_diagnostics_signs_priority = 1
    g:lsp_diagnostics_signs_insert_mode_enabled = 1
    g:lsp_diagnostics_signs_enabled = 1
endif

```

## TypeScript

pour un support typescript plus interessant:
```
//terminal:
git clone https://github.com/Quramy/tsuquyomi/ ~/.vim/bundle/tsc

//dans vim:
 :LspInstallServer

//dans votre .vimrc a la fin dans YOUR CONFIG:
g:syntastic_typescript_checkers = ['tsuquyomi']
g:tsuquyomi_disable_quickfix = 1

if expand('%:e') == '.ts'                     
    var lsp_diagnostics_enabled = 1
    g:lsp_diagnostics_signs_priority = 1
    g:lsp_diagnostics_signs_insert_mode_enabled = 1
    g:lsp_diagnostics_signs_enabled = 1
endif

```


# Autre chose ? une idée ?
ouvrez un ticket ! ou mp moi sur discord (nda-cunh) ou demandez le moi directement
je suis à l'écoute d'un peu tout :)
