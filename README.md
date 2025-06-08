# My Dotfiles ⚡

This repo hosts my config files for several tools. It utilizes
[chezmoi](https://github.com/twpayne/chezmoi), a dotfiles manager.

## Usage

> ℹ️ Will probably exclude the submodules so long as they're private

Clone this using:

```bash
chezmoi init --apply git@github.com:SuchWowEl/dotfiles.git
```

optionally to pull the latest commits for the submodules,

```bash
chezmoi cd
git submodule update --remote
chezmoi apply
```

or simply,

```bash
just mods-pull
```

## Todo

- check if pulling this into a new machine works automagically
- slowly publicize submodules 👀
