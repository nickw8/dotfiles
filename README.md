# 🛠️ Dotfiles with ChezMoi + Mise + Zinit

This repository contains my cross-platform dotfiles, managed with [chezmoi](https://www.chezmoi.io/) and powered by [mise](https://mise.jdx.dev/) and [zinit](https://github.com/zdharma-continuum/zinit).

It’s designed to work seamlessly on macOS, Linux, and WSL, providing:

- 🧩 Modular dotfiles
- ⚡ Fast and reproducible CLI tool installs
- 🧵 Minimal shell startup time (no heavy eval calls)
- 🗂 Clean separation between shell config, completions, and tools

---

## 🚀 Bootstrap Instructions

On a new machine:

```bash
# 1. Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)"

# 2. Initialize dotfiles
chezmoi init git@github.com:nickw8/dotfiles.git

# 3. Apply dotfiles and setup scripts
chezmoi apply
```

## 🏗 Directory structure

| File / Folder | Purpose |
|---------------|---------|
| `.chezmoiignore` | Excludes runtime/generated files |
| `.zshenv` | Universal env vars (XDG, LANG, etc.) |
| `.zprofile` | Login-shell setup (EDITOR, agents) |
| `.zshrc` | Interactive shell config (prompt, zinit, completions) |
| `.mise.toml` | Tool + language versions (via mise) |
| `run_once_01_setup_xdg_dirs.sh.tmpl` | Creates XDG base directories |
| `run_once_02_install_mise.sh.tmpl` | Installs mise + tools + plugins |
| `run_once_03_generate_completions.sh.tmpl` | Generates static zsh completions |
| `scripts/` | Optional extra scripts |

## 🧩 Tools managed by mise

- eza, fzf, ripgrep, zoxide, bat, fd
- node, python, go, rust
- direnv, delta, shellcheck, btop, pug, tenv, carapace, atuin, k9s

## ⚡ Shell completions

- Generated once into `$XDG_CONFIG_HOME/zsh/_toolname.zsh` by chezmoi scripts
- Loaded as static snippets via zinit

## 📦 Installation flow

1. `01_setup_xdg_dirs.sh.tmpl` → make sure folders exist  
2. `02_install_mise.sh.tmpl` → install mise + tools  
3. `03_generate_completions.sh.tmpl` → precompute completions

## 🛡️ Notes

- Mise environment (`mise activate zsh`) is precomputed → no eval in `.zshrc`  
- Global mise tools are prioritized in PATH (`~/.local/share/mise/shims`)  
- `.zshrc` focuses only on config, aliases, prompt, and plugin loading

## 📜 Updating completions or mise env

```bash
chezmoi apply
```

## ✨ Credits

- [chezmoi](https://chezmoi.io/)
- [mise](https://mise.jdx.dev/)
- [zinit](https://github.com/zdharma-continuum/zinit)
