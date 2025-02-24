#!/usr/bin/env bash

##############################################
# Set up devbox
##############################################

# Install devbox if not installed already
curl -fsSL https://get.jetify.com/devbox | bash

# NOTE: change this as necessary
devbox_dir="$HOME/Repo/personal/devbox"

if [[ ! -d "$devbox_dir" ]]; then
  echo "Creating devbox dir at '$devbox_dir'"
  mkdir -p "$devbox_dir"
fi

git clone "https://github.com/eeternalsadness/devbox.git" "$devbox_dir"

echo "Creating symlink for 'devbox.json' at '$HOME/devbox.json'"
ln -sf "${devbox_dir}/devbox.json" "$HOME/devbox.json"

# NOTE: update the values in the .env file as necessary
echo "Copying 'template.env' to '$devbox_dir/.env'"
cp "${devbox_dir}/template.env" "$devbox_dir/.env"
echo "Creating symlink for '.env' at '$HOME/.env'"
ln -sf "${devbox_dir}/.env" "$HOME/.env"

#vim "$HOME/.env"

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

# NOTE: change this as necessary
scripts_dir="$HOME/Repo/personal/scripts"

if [[ ! -d "$scripts_dir" ]]; then
  echo "Creating scripts dir at '$scripts_dir'"
  mkdir -p "$scripts_dir"
fi

git clone "https://github.com/eeternalsadness/scripts.git" "$scripts_dir"

##############################################
# Run devbox install to finish setup
##############################################

devbox install -c $HOME

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
