dotfiles_refresh_shell_assets() {
  if [ "$#" -ne 1 ]; then
    printf '%s\n' "usage: dotfiles_refresh_shell_assets <tool>" >&2
    return 1
  fi

  tool=$1
  xdg_config_home=${XDG_CONFIG_HOME:-$HOME/.config}
  xdg_data_home=${XDG_DATA_HOME:-$HOME/.local/share}

  mkdir -p \
    "$xdg_config_home/nushell/autoload" \
    "$xdg_config_home/zsh/vendors" \
    "$xdg_data_home/zsh/site-functions"

  case "$tool" in
    mise)
      mise activate zsh > "$xdg_config_home/zsh/vendors/mise.zsh"
      mise completion zsh > "$xdg_data_home/zsh/site-functions/_mise"
      mise activate nu > "$xdg_config_home/nushell/autoload/mise.nu"
      ;;
    k9s)
      k9s completion zsh > "$xdg_data_home/zsh/site-functions/_k9s"
      ;;
    usage)
      usage generate completion zsh usage --usage-cmd 'usage --usage-spec' > "$xdg_data_home/zsh/site-functions/_usage"
      ;;
    zoxide)
      zoxide init zsh > "$xdg_config_home/zsh/vendors/zoxide.zsh"
      zoxide init nushell > "$xdg_config_home/nushell/autoload/zoxide.nu"
      ;;
    atuin)
      atuin init zsh > "$xdg_config_home/zsh/vendors/atuin.zsh"
      atuin init nu > "$xdg_config_home/nushell/autoload/atuin.nu"
      ;;
    carapace)
      carapace _carapace zsh > "$xdg_config_home/zsh/vendors/carapace.zsh"
      carapace _carapace nushell > "$xdg_config_home/nushell/autoload/carapace.nu"
      ;;
    *)
      printf '%s\n' "dotfiles-refresh-shell-assets: unsupported tool '$tool'" >&2
      return 1
      ;;
  esac
}
