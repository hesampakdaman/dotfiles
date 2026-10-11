# dotfiles
Personal Linux dotfiles managed as a literate org file. Configuration blocks are tangled to their target locations, and packages are declared with `system-pkg`.

## Bootstrap
We assume `emacs` is installed and run the following command,
```bash
$ emacs --batch -l org dotfiles.org -f org-babel-tangle
```
which generates the actual configuration files in `$HOME`. The normal workflow is to edit `dotfiles.org` and save to re-tangle.

Batch tangling only writes files. Packages are installed on save from Emacs, where `.dir-locals.el` enables `system-pkg-mode` (defined in `~/.emacs.d/init.org`), evaluates the `system-pkg` declarations and installs anything missing with `yay`.

## One-time setup
```bash
$ systemctl --user enable --now ashell.service check-updates.timer
```

## Generated files
Some configs are written by `matugen` from templates in `~/.config/matugen/`, not by tangling. Run `matugen` after changing them:
- `~/.config/ashell/config.toml`
- `~/.config/hypr/colors.lua`, `~/.config/ghostty/themes/Matugen`, `~/.config/rofi/colors.rasi`, `~/.config/mako/config`
- `~/.bash_ps1.sh`, `~/.dircolors`, `~/.emacs.d/matugen.el`

## Machine-local overrides
These files are read if present and are not tracked:
- `~/.bashrc.local`
- `~/.config/hypr/machine.lua` (monitors, workspaces, gaps, input)
- `~/.config/ghostty/local.conf`
- `~/.gitconfig-home` / `~/.gitconfig-work` (via `includeIf`)

## Removing a block
Tangling never deletes files. When a block is removed, delete its old target in `$HOME` by hand.
