# dotfiles
Personal Linux dotfiles managed as a literate org file. Configuration blocks are tangled to their target locations, and packages are declared with `system-pkg`.

## Bootstrap
We assume `emacs` is installed and run the following command,
```bash
$ emacs --batch -l org dotfiles.org -f org-babel-tangle
```
which generates the actual configuration files in `$HOME`. The normal workflow is to edit `dotfiles.org` and save to re-tangle.

Batch tangling only writes files. Packages are installed on save from Emacs, where `.dir-locals.el` enables `system-pkg-mode` (defined in `~/.emacs.d/init.org`), evaluates the `system-pkg` declarations and installs anything missing with `yay`.

## New machine
1. Install `git`, `emacs` and `yay` (yay is built by hand from the AUR the first time).
2. Clone the Emacs config to `~/.emacs.d`. It defines `system-pkg` and the `hesam-matugen-*` functions that hypridle, waypaper and matugen call.
3. Clone this repo to `~/dotfiles`, open `dotfiles.org` in Emacs and save. This tangles every file, installs missing packages and adds waypaper's `post_command`.
4. Optionally add machine-local overrides, such as monitors and workspaces (see [Machine-local overrides](#machine-local-overrides)).
5. Generate the colour files once with `matugen image <wallpaper>`. Until then Hyprland uses fallback colours, and ghostty and rofi report a missing theme or `colors.rasi`.
6. Enable the user units:
   ```bash
   $ systemctl --user enable --now ashell.service check-updates.timer
   ```
7. Log in to Hyprland.

## Generated files
Some configs are written by `matugen` from templates in `~/.config/matugen/`, not by tangling. Run `matugen` after changing them:
- `~/.config/ashell/config.toml`
- `~/.config/hypr/colors.lua`, `~/.config/ghostty/themes/Matugen`, `~/.config/rofi/colors.rasi`, `~/.config/mako/config`
- `~/.bash_ps1.sh`, `~/.dircolors`, `~/.emacs.d/matugen.el`
- `/var/lib/greeter-theme/default.conf.user` (SDDM login screen; needs the one-time setup in the `sddm` template section)

## Machine-local overrides
These files are read if present:
- `~/.bashrc.local`
- `~/.config/hypr/machine.lua` (monitors, workspaces, gaps, input)
- `~/.config/ghostty/local.conf`
- `~/.gitconfig-home` / `~/.gitconfig-work` (via `includeIf`)

To track them, add `machines/<hostname>.org` (see `machines/fibonacci.org`) and tangle it like `dotfiles.org`:
```bash
$ emacs --batch -l org machines/$(hostname).org -f org-babel-tangle
```
Its blocks tangle only when the host name matches, so saving it on another machine writes nothing. Keep secrets in untracked files.

## Laptop sleep
hypridle suspends with `systemctl suspend-then-hibernate` and falls back to plain suspend where hibernate isn't set up. To hibernate after 30 minutes of sleep, check that `systemctl hibernate` works (swap at least as large as RAM, `resume=` on the kernel command line), then add the drop-ins below. They live in `/etc`, so they aren't tangled.
```bash
$ sudo mkdir -p /etc/systemd/sleep.conf.d /etc/systemd/logind.conf.d
$ printf '[Sleep]\nHibernateDelaySec=30min\n' | sudo tee /etc/systemd/sleep.conf.d/hibernate.conf
$ printf '[Login]\nHandleLidSwitch=suspend-then-hibernate\n' | sudo tee /etc/systemd/logind.conf.d/lid.conf
```

## Removing a block
Tangling never deletes files. When a block is removed, delete its old target in `$HOME` by hand.
