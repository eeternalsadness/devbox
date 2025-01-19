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
  echo "Creating devbox dir at '$devbox_dir'"
  mkdir -p "$devbox_dir"
fi

git clone "https://github.com/eeternalsadness/devbox.git" "$devbox_dir"

echo "Creating symlink for 'devbox.json' at '$HOME/devbox.json'"
ln -s "${devbox_dir}/devbox.json" "$HOME/devbox.json"

# NOTE: update the values in the .env file as necessary
echo "Copying 'template.env' to '$HOME/.env'"
cp "${devbox_dir}/template.env" "$HOME/.env"

##############################################
# Set up dotfiles
##############################################

# NOTE: change this as necessary
dotfiles_dir="$HOME/Repo/personal/dotfiles"

if [[ ! -d "$dotfiles_dir" ]]; then
  echo "Creating dotfiles dir at '$dotfiles_dir'"
  mkdir -p "$dotfiles_dir"
fi

git clone "https://github.com/eeternalsadness/dotfiles.git" "$dotfiles_dir"

# Symlink dotfiles
echo "Linking dotfiles..."
cd "$dotfiles_dir"

for file in .*; do
  # Ignore special files
  if [[ "$file" == "." || "$file" == ".." || "$file" == ".git" || "$file" == ".gitignore" ]]; then
    continue
  fi

  target="$HOME/$file"

  # Create symlink
  echo "Creating symlink for '$file' at '$target'"
  ln -s "$dotfiles_dir/$file" "$target"
done

echo "Reminders:"
echo "- Modify the values in '$HOME/.env' as necessary"
