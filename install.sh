!/bin/bash

# $1 - Package manager

function show_help {
	echo "Linux Setup as Z mode v1.0 - Zurdi Zurdo"
	echo "Released under the GNU GLP"
	echo ""
	echo "Usage: ./z_setup.sh [package manager]"
}

if [ -z $1 ]; then
	echo "Package manager needed"
	echo ""
	show_help
	exit 1
fi
pm=$1

# PPA for i3-gaps
sudo add-apt-repository -y ppa:regolith-linux/stable
sudo add-apt-repository -y ppa:papirus/papirus
sudo apt upgrade

# Packages
echo "Installing packages"
sudo ${pm} install curl -y
sudo ${pm} install neovim -y
sudo ${pm} install ranger -y
sudo ${pm} install polybar -y
sudo ${pm} install i3-gaps -y
sudo ${pm} install firefox -y
sudo ${pm} install rofi -y
sudo ${pm} install papirus-icon-theme -y
sudo ${pm} install nautilus -y
sudo ${pm} install tilix -y
sudo ${pm} install zsh -y
sudo ${pm} install ruby -y
sudo ${pm} install ruby-dev -y
sudo ${pm} install build-essential -y
sudo ${pm} autoremove -y
sudo gem install colorls

# Fonts
echo "Installing fonts"
if [ ! -d ~/.fonts ]; then
	mkdir ~/.fonts
fi
wget -O ~/.fonts/Ubuntu_Mono_Nerd_Font_Complete.ttf https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/UbuntuMono/Regular/complete/Ubuntu%20Mono%20Nerd%20Font%20Complete.ttf
wget -O ~/.fonts/JetBrains_Mono_Regular_Nerd_Font_Complete_Mono.ttf https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
fc-cache -f -v

# SDKMAN
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# uLauncher
wget https://github.com/Ulauncher/Ulauncher/releases/download/5.8.0/ulauncher_5.8.0_all.deb
sudo dpkg -i ulauncher_5.8.0_all.deb
rm ulauncher_5.8.0_all.deb
git clone https://github.com/KiranWells/ulauncher-nord/ ~/.config/ulauncher/user-themes/nord

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Zsh plugins
## Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

## Syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

## Fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Ranger devicons
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
echo "default_linemode devicons" >> $HOME/.config/ranger/rc.conf

# Instructions for minimal Firefox
echo """
    Verify that the user stylesheets (userChrome) option is enabled:

        Go to the address about:config in Firefox

        Search for toolkit.legacyUserProfileCustomizations.stylesheets

        Confirm the option is set to true

    Make sure that you have the Default theme enabled
        Go to the address about:addons
        Enable the Default theme if not already enabled
"""
read -p "Press any key when you are ready... " key

sh -c "$(curl -fsSL https://raw.githubusercontent.com/mut-ex/minimal-functional-fox/master/install.sh)"

echo """
    Select the Customize option from the hamburger menu (≡), and remove all items except for:

        Forward button
        Back button
        Downloads button

"""

read -p "Press any key when you are ready... " key

# Copy the .config folder
cp -r dots/neodots/* ~
