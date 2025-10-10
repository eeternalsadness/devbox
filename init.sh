#!/bin/bash bash

set -euo pipefail

# NOTE: change these as necessary
devbox_dir="$HOME/Repo/personal/devbox"
dotfiles_dir="$HOME/Repo/personal/dotfiles"
scripts_dir="$HOME/Repo/personal/scripts"

##############################################
# Set up devbox
##############################################

# Install devbox if not installed already
curl -fsSL https://get.jetify.com/devbox | bash

if [[ ! -d "$devbox_dir" ]]; then
  echo "Creating devbox dir at '$devbox_dir'"
  mkdir -p "$devbox_dir"
fi

git clone "https://github.com/eeternalsadness/devbox.git" "$devbox_dir"

# Init devbox projects
for dir in $devbox_dir/*/; do
  echo "Copying '${dir}/template.env' to '$dir/.env'"
  cp "${dir}/template.env" "${dir}/.env"
done

##############################################
# Set up dotfiles
##############################################

if [[ ! -d "$dotfiles_dir" ]]; then
  echo "Creating dotfiles dir at '$dotfiles_dir'"
  mkdir -p "$dotfiles_dir"
fi

git clone "https://github.com/eeternalsadness/dotfiles.git" "$dotfiles_dir"

# Symlink dotfiles
echo "Linking dotfiles..."

for file in $dotfiles_dir/.*; do
  file_name=$(basename "$file")

  # Ignore folders & special files
  if [[ -d "$file" ]] || [[ "$file_name" == ".gitignore" ]]; then
    continue
  fi

  target="$HOME/$file_name"

  # Create symlink
  echo "Creating symlink for '$file' at '$target'"
  ln -sf "$file" "$target"
done

# Symlink dirs in .config/
if [[ ! -d "$HOME/.config" ]]; then
  mkdir "$HOME/.config"
fi

for file in $dotfiles_dir/.config/*; do
  file_name=$(basename "$file")

  # Ignore special files
  if [[ "$file_name" == ".git" || "$file_name" == ".gitignore" ]]; then
    continue
  fi

  target="$HOME/.config/$file_name"

  # Create symlink
  echo "Creating symlink for '$file' at '$target'"
  ln -sf "$file" "$target"
done

##############################################
# Set up scripts
##############################################

if [[ ! -d "$scripts_dir" ]]; then
  echo "Creating scripts dir at '$scripts_dir'"
  mkdir -p "$scripts_dir"
fi

git clone "https://github.com/eeternalsadness/scripts.git" "$scripts_dir"

##############################################
# Run devbox install to finish setup
##############################################

source "$scripts_dir/devbox/common.sh"
devbox_env=$(get_devbox_env "$devbox_dir")
if [[ -n "$devbox_env" ]]; then
  devbox install -c "${devbox_dir}/${devbox_env}"
fi
#devbox run -c $HOME install_jira

##############################################
# Reminders after script completion
##############################################

echo -e "\n============================================================\n"
echo "Reminders:"
echo "- Devbox repo installed at '$devbox_dir'"
echo "- Dotfiles repo installed at '$dotfiles_dir'"
echo "- Scripts repo installed at '$scripts_dir'"
echo "- Modify the environment variables in '$devbox_dir/{env}/.env' as necessary"
echo -e "\nRun 'dbs' to start your shell environment :D"
