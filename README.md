# My Dotfiles ⚡

This repo hosts my config files for several tools. It utilizes
[chezmoi](https://github.com/twpayne/chezmoi), a dotfiles manager.
Made with arch as the target distro, and intended for my personal use.

## Usage

### Pre-requisites

- Install git
- Doppler doesn't store any ssh key, so create one and register it to
GitHub
- On windows, install [`Wezterm`](https://wezterm.org/install/windows.html).

Clone this using:

```bash
chezmoi init --apply git@github.com:SuchWowEl/dotfiles.git
```
