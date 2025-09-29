#!/usr/bin/env bash

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
for dir in */; do
  echo "Copying '${devbox_dir}/${dir}/template.env' to '$devbox_dir/$dir/.env'"
  cp "${devbox_dir}/${dir}/template.env" "${devbox_dir}/${dir}/.env"
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

devbox install -c $HOME
#devbox run -c $HOME install_jira

##############################################
# Reminders after script completion
##############################################

echo -e "\n============================================================\n"
echo "Reminders:"
echo "- Devbox repo installed at '$devbox_dir'"
echo "- Dotfiles repo installed at '$dotfiles_dir'"
echo "- Scripts repo installed at '$scripts_dir'"
echo "- Modify the values in '$HOME/.env' as necessary"
echo -e "\nRun 'devbox shell' in $HOME to start your shell environment :D"
