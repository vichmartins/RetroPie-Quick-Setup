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
sudo -u $SUDO_USER git clone --depth=1 https://github.com/lipebello/es-theme-retrorama.git /home/$SUDO_USER/.emulationstation/themes/retrorama
sudo -u $SUDO_USER git clone --depth=1 https://github.com/TMNTturtleguy/es-theme-ComicBook.git /home/$SUDO_USER/.emulationstation/themes/ComicBook
sudo -u $SUDO_USER git clone --depth=1 https://github.com/hoover900/es-theme-Not-so-Epic.git /home/$SUDO_USER/.emulationstation/themes/Not-so-Epic
sudo -u $SUDO_USER git clone --depth=1 https://github.com/fagnerpc/Alekfull-ARTFLIX.git /home/$SUDO_USER/.emulationstation/themes/Alekfull-ARTFLIX
sudo -u $SUDO_USER git clone --depth=1 https://github.com/pajarorrojo/es-theme-PlayStation-X.git /home/$SUDO_USER/.emulationstation/themes/PlayStation-X

#Reboot
reboot