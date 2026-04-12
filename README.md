# dotfiles
Personal Linux dotfiles managed as a literate org file. Configuration blocks are tangled to their target locations, and packages are declared with `system-pkg`.

## Bootstrap
We assume `emacs` is installed and run the following command,
```bash
$ emacs --batch -l org dotfiles.org -f org-babel-tangle
```
which generates the actual configuration files in `$HOME`. The normal workflow is to edit `dotfiles.org` and save to re-tangle.
