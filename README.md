# SupraVim 5.15

# [The SupraWiki (help and documentation) Click here](https://gitlab.com/hydrasho/SupraVim/-/wikis/home)

### Dependencies
| Vim 9 | C or Vala compiler |
|-------| ------------------ |

## Install with Curl
```bash
curl https://gitlab.com/nda-cunh/SupraVim/-/raw/master/install.sh | sh
```

#### Update:
```bash
supravim --update
```

#### Uninstall

```bash
supravim --uninstall
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

