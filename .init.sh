#!/bin/bash

# Check if the system is running Arch Linux
if [ -f /etc/os-release ] && grep -q "Arch Linux" /etc/os-release; then
  echo "🔧 yay not found — installing..."

  # Create temp build dir
  cd ~ || exit
  mkdir -p yay_install && cd yay_install || exit

  # Install prerequisites
  sudo pacman -S --needed --noconfirm git base-devel

  # Clone and build yay
  git clone https://aur.archlinux.org/yay.git
  cd yay || exit
  makepkg -si --noconfirm

  # Configure yay
  yay -Y --gendb
  yay -Y --devel --save
  echo "✅ yay installation complete!"

  echo "📦 Installing doppler-cli..."
  yay -S --noconfirm doppler-cli
  echo "✅ doppler-cli installed successfully!"

  echo "📦 Installing brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "✅ brew installed successfully!"
fi
