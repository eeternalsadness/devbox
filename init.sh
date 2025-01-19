#!/usr/bin/env bash

#pkg_manager_cmd="apt"
#
#if [ "$(uname -s)" = "Darwin" ]; then
#  # install brew if not installed
#  if ! [ brew --version ] &>/dev/null; then
#    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#  fi
#  pkg_manager_cmd="brew"
#elif [ -f /etc/os-release ]; then
#  local linux_distro=$(grep "^ID=" /etc/os-release | sed 's/^ID=//')
#  case "$linux_distro" in
#  ubuntu)
#    pkg_manager_cmd="apt"
#    ;;
#  *)
#    pkg_manager_cmd="apt"
#    ;;
#  esac
#else
#  echo "Unknown Operating System!"
#  exit 1
#fi
#
#install_common_packages() {
#}

##############################################
# Set up devbox
##############################################

# NOTE: change this as necessary
devbox_dir="$HOME/Repo/personal/devbox"

if [[ ! -d "$devbox_dir" ]]; then
  mkdir -p "$devbox_dir"
fi

git clone "https://github.com/eeternalsadness/devbox.git" "$devbox_dir"
