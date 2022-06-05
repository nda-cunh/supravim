# SupraVim

L'editeur de texte vim pour 42 Angoulême.

<img src="readme.png"/>

## Installation:

```bash
curl https://gitlab.com/hydrasho/SupraVim/-/raw/master/installer.sh | sh
```
**Dépendance**


| Zsh | Clang | Vim 8 |
|-----|-------|-------|



## Désinstallation

```bash
    rm -rf ~/.local/bin/SupraVim
```
## Utilisation

| Nom | Raccourcis |
| ------ | ------ |
| Quitter | Ctrl + Q |
| Sauvegarde | Ctrl + S ou Ctrl + W |
| HEADER 42| **F1**|
| Norminette | **F3**|
| Compilation | **F5**|
| Debogueur | **Ctrl + F5**|
| Deplacement | Shift - flèche|
| Fermer/Ouvrir la fenêtre des dossiers | Ctrl +G |
| scinder la fenetre horizontalement | Ctrl + D|
| scinder la fenetre verticalement | Shift + D|
| Crée un nouvelle onglet | Ctrl + N|
| Déplacement entre onglet | Ctrl + Flèche|

# Compilation

Vous pouvez compiler votre programme avec la touche F5
si votre projet contient un Makefile, celui-ci le detectera et executera la regle
ALL,  suivie de la regle RUN.

sinon si il ne contient pas de Makefile,
il compilera tout les fichier C present ensemble et executera le a.out généré.

# Nouveauté de la 2.0

- supports des onglets
- Ajout de l'intégration GDB
- UNDO infinit ! (se sauvegarde même après la fermeture)
- Generateur de prototype pour les headers C
- Commenter , Decommenter en selectionnant ou une ligne
