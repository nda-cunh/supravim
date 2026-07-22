# Tests SupraVim

Lancer la suite complète :

```sh
./test/run.sh
```

Chaque script est autonome et retourne un code de sortie non nul en cas d'échec.

## `smoke.sh`

Deux vérifications :

1. **Démarrage** — le `vimrc` est rendu depuis `vimrc.in`, l'arbre `data/supravim/vim`
   est copié dans un `$HOME` jetable, et Vim démarre puis quitte. Toute erreur
   *non rattrapée* remontée sur stderr fait échouer le test.
2. **Colorschemes** — chaque fichier de `colors/` est chargé via `:colorscheme`
   dans une instance neuve.

Le test lit **stderr**, et non `verbosefile`. C'est délibéré : `verbosefile`
journalise aussi les erreurs rattrapées par `try`/`catch`, ce qui produit une
dizaine de faux positifs sur ce dépôt. stderr ne contient que les erreurs
réellement non rattrapées, donc visibles par l'utilisateur.

De même, le démarrage n'utilise pas `-es` (mode Ex). Ce mode désactive mappings
et groupes d'autocommandes, ce qui génère des `E31`/`E216` parasites sans rapport
avec un vrai bug.

## `compile.sh`

Force la compilation de chaque script Vim9 via `:defcompile`, sans l'exécuter.
Cela attrape statiquement les erreurs de type, variables inconnues et mauvaises
signatures.

Deux contraintes dictent le fonctionnement du script :

- `:defcompile` passé en `-c` ne compile rien, car le contexte du script est déjà
  perdu. La directive doit se trouver **dans** le fichier ; le script l'ajoute donc
  à une copie.
- Le préfixe des fonctions autoload dérive du **chemin** du fichier. La copie doit
  conserver nom et arborescence relative, d'où la copie de l'arbre entier dans un
  répertoire de staging plutôt qu'un fichier temporaire isolé.

Ici la lecture se fait sur `verbosefile`, car une erreur de compilation n'est pas
rattrapable et le message n'apparaît pas sur stderr en mode `-es`.

## `stubs/`

Bouchons pour les dépendances installées par suprapack et absentes du dépôt
(`vim-airline`, `SupraTree`, `Crumble`, `norminette`).

Attention au placement des fonctions autoload : pour `foo#bar#baz`, Vim charge
`autoload/foo/bar.vim`. `airline#section#create` va donc dans
`autoload/airline/section.vim`, et non `autoload/airline.vim`.

## `external-deps.txt`

Fichiers exclus de `compile.sh` parce qu'ils importent des modules fournis par des
paquets suprapack séparés (`fuzzbox/selector.vim`, `SupraPop/Base.vim`). Ils ne
sont pas compilables tant que ces paquets ne sont pas installés.

Retirer une ligne de ce fichier dès que la dépendance correspondante devient
disponible dans le dépôt ou dans l'image CI.
