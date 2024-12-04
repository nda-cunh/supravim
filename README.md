# SupraVim 5.43

# [The SupraWiki (help and documentation) Click here](https://gitlab.com/nda-cunh/SupraVim/-/wikis/home)


# How Install 
### Dependencies

| Vim 9 | C or Vala compiler |
|-------| ------------------ |

## with curl
```bash
curl https://gitlab.com/nda-cunh/SupraVim/-/raw/master/install.sh | sh
```

## with suprapack
```bash
suprapack install supravim
```

# Update & Uninstall

#### Update:
```bash
supravim --update
```

#### Uninstall

```bash
supravim --uninstall
```

# SupraProject

## Suprapack

Suprapack est le gestionnaire de paquets de Supravim. Il permet d'installer, de désinstaller et de gérer des plugins, des binaires et des librairies. Avec Suprapack, tu peux exécuter des commandes telles que :

-  `suprapack install` pour installer un plugin.
-  `suprapack remove`  pour désinstaller un plugin.
-  `suprapack list`    pour afficher la liste des packages installés.
-  `suprapack update`  pour mettre à jour les plugins.

## Suprabear
Suprabear est un programme qui génère un fichier compile_commands.json. Il permet donc de parser le Makefile du projet pour generer le compile_commands.json. ce fichier est utilisé par la majorité des IDE dont VScode, Vim et la Jetbrain suite
avec ce json l'ide peut comprendre comment votre projet fonctionne et apporte une meilleur aide.

## Supramake
supramake est une commande qui fonctionne de manière similaire à make, mais elle est spécifiquement conçue pour rechercher le Makefile associé au projet. Cela permet de compiler et d'exécuter des programmes de manière efficace

Compatibility:
  - Makefile
  - Meson build
  - Vala
  - C and C++
  - Python
  - Shell
  - Rust
  - Assembly

supramake ajoute les arguments dans $(ARGS)
pour l'appeler il suffit d'ajouter `--`
ex: `supramake all -- 5 4 3 2 1`
```makefile
all:
    echo $(ARGS)
```


# note

N'hésitez pas à découvrir d'autre éditeur de texte, ou d'ide ou de construire votre propre configuration VIM la seule limite et votre pensée. savoir configurer ses outils , c'est aussi être plus à l'aise avec votre travail.

<img src="readme.png"/>

# Autre chose ? une idée ?
ouvrez un ticket ! ou mp moi sur discord (nda-cunh) ou demandez le moi directement
je suis à l'écoute d'un peu tout :)

MP moi sur le discord/slack de 42 si besoin (nda-cunh)

# Developper

## How build ?

you need suprapack to build it
```bash
git clone https://gitlab.com/nda-cunh/SupraVim
cd SupraVim
# Modifiy
suprapack build usr
# Install the new version with it
suprapack add supravim-*.suprapack
```

