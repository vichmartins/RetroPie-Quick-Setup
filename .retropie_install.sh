#!/bin/bash
# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo:"
    echo "sudo $0"
    exit 1
fi

# Clears out motd messages when user logins.
rm -rf /etc/update-motd.d/*
truncate -s 0 /etc/motd

# Create a MOTD script
cat << 'EOF' > /etc/update-motd.d/01-retropie
#!/bin/bash
echo ""
echo -e "\033[31m    ____       __            __  _     \033[0m"
echo -e "\033[31m   / __ \___  / /__________ / __  \(_)___ \033[0m"
echo -e "\033[31m  / /_/ / _ \/ __/ ___/ __ \/ /_/ / / _ \ \033[0m"
echo -e "\033[31m / _, _/  __/ /_/ /  / /_/ / ____/ /  __/ \033[0m"
echo -e "\033[31m/_/ |_|\___/\__/_/   \____/_/   /_/\___/  \033[0m"
echo ""
echo "Welcome to RetroPie!"
echo "System: $(uname -n)"
echo "Date: $(date)"
echo ""
EOF

# Make the script executable
chmod +x /etc/update-motd.d/01-retropie

# Add EmulationStation auto-start to bashrc
sudo -u "$SUDO_USER" bash -c 'cat << "EOF" >> ~/.bashrc
if [[ -z "$SSH_CLIENT" && -z "$SSH_TTY" && -z "$SSH_CONNECTION" ]]; then
    if [[ $- == *i* ]]; then
        emulationstation
    fi
fi
EOF'

# Install required packages
apt update && sudo apt -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" full-upgrade -y
apt install -y git dialog unzip xmlstarlet

# Clone RetroPie setup
git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git .RetroPie-Setup

# Change to directory and run setup
cd .RetroPie-Setup

#./Installs the basic packages for RetroPie.
./retropie_packages.sh setup basic_install

#Enables auto-login.
raspi-config nonint do_boot_behaviour B2

#Set of Themes for EmulationStation
git clone --depth=1 https://github.com/lipebello/es-theme-retrorama.git /home/$SUDO_USER/.emulationstation/themes/retrorama
git clone --depth=1 https://github.com/c64-dev/es-theme-epicnoir.git /home/$SUDO_USER/.emulationstation/themes/epicnoir
git clone --depth=1 https://github.com/TMNTturtleguy/es-theme-ComicBook.git /home/$SUDO_USER/.emulationstation/themes/ComicBook
git clone --depth=1 https://github.com/hoover900/es-theme-Not-so-Epic.git /home/$SUDO_USER/.emulationstation/themes/Not-so-Epic
git clone --depth=1 https://github.com/fagnerpc/Alekfull-ARTFLIX.git /home/$SUDO_USER/.emulationstation/themes/Alekfull-ARTFLIX
git clone --depth=1 https://github.com/TheGrizzMD/artflix-revisited-es-de.git /home/$SUDO_USER/.emulationstation/themes/artflix-revisited-es-de
git clone --depth=1 https://github.com/galisteogames/ARTFLIX-Cobalto.git /home/$SUDO_USER/.emulationstation/themes/ARTFLIX-Cobalto
git clone --depth=1 https://github.com/pajarorrojo/es-theme-PlayStation-X.git /home/$SUDO_USER/.emulationstation/themes/PlayStation-X
git clone --depth=1 https://github.com/anthonycaccese/art-book-next-es.git /home/$SUDO_USER/.emulationstation/themes/art-book-next-es
git clone --depth=1 https://github.com/mluizvitor/es-theme-elementerial.git /home/$SUDO_USER/.emulationstation/themes/elementerial
git clone --depth=1 https://github.com/anthonycaccese/art-book-next-es-de.git /home/$SUDO_USER/.emulationstation/themes/art-book-next-es-de
git clone --depth=1 https://github.com/anthonycaccese/alekfull-nx-es-de.git /home/$SUDO_USER/.emulationstation/themes/alekfull-nx-es-de
git clone --depth=1 https://github.com/prefect421/es-theme-lcars-p42.git /home/$SUDO_USER/.emulationstation/themes/lcars-p42
git clone --depth=1 https://github.com/anthonycaccese/colorful-simplified-es-de.git /home/$SUDO_USER/.emulationstation/themes/colorful-simplified-es-de
git clone --depth=1 https://github.com/anthonycaccese/nso-menu-interpreted-es-de.git /home/$SUDO_USER/.emulationstation/themes/nso-menu-interpreted-es-de
git clone --depth=1 https://github.com/anthonycaccese/art-book-next-retropie.git /home/$SUDO_USER/.emulationstation/themes/art-book-next-retropie
git clone --depth=1 https://github.com/anthonycaccese/epic-noir-revisited-es-de.git /home/$SUDO_USER/.emulationstation/themes/epic-noir-revisited-es-de
git clone --depth=1 https://github.com/anthonycaccese/techdweeb-es-de.git /home/$SUDO_USER/.emulationstation/themes/techdweeb-es-de
git clone --depth=1 https://github.com/anthonycaccese/immersive-revisited-es-de.git /home/$SUDO_USER/.emulationstation/themes/immersive-revisited-es-de
git clone --depth=1 https://github.com/anthonycaccese/minui-menu-es-de.git /home/$SUDO_USER/.emulationstation/themes/minui-menu-es-de
git clone --depth=1 https://github.com/anthonycaccese/colorful-revisited-es-de.git /home/$SUDO_USER/.emulationstation/themes/colorful-revisited-es-de
git clone --depth=1 https://github.com/anthonycaccese/retromega-revisited-es-de.git /home/$SUDO_USER/.emulationstation/themes/retromega-revisited-es-de
git clone --depth=1 https://github.com/anthonycaccese/mister-menu-es-de.git /home/$SUDO_USER/.emulationstation/themes/mister-menu-es-de
git clone --depth=1 https://github.com/anthonycaccese/mania-menu-es-de.git /home/$SUDO_USER/.emulationstation/themes/mania-menu-es-de
git clone --depth=1 https://github.com/lioneil/obsidian-es-theme-retropie.git /home/$SUDO_USER/.emulationstation/themes/obsidian
git clone --depth=1 https://github.com/anthonycaccese/art-book-next-jelos.git /home/$SUDO_USER/.emulationstation/themes/art-book-next-jelos
git clone --depth=1 https://github.com/anthonycaccese/epic-noir-next-es-de.git /home/$SUDO_USER/.emulationstation/themes/epic-noir-next-es-de
git clone --depth=1 https://github.com/kaleben0/es-fusion-slice.git /home/$SUDO_USER/.emulationstation/themes/es-fusion-slice
git clone --depth=1 https://github.com/XyberDAWG/es-theme-fundamental.git /home/$SUDO_USER/.emulationstation/themes/fundamental


#Reboot
reboot