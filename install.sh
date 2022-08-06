#!/bin/bash
# ----------------------------------- Wlan support --------------------------------
sudo dnf in dkms bc -y
#sudo rsync -rvhP ./ /usr/src/rtl88x2bu-5.8.7.1
#sudo dkms add -m rtl88x2bu -v 5.8.7.1
sudo dnf copr enable farribeiro/rtl88x2bu-kmod -y
sudo dnf in rtl88x2bu-kmod -y 
# ----------------------------------- Gnome themming --------------------------------
mkdir /home/$USER/.themes
cp -rf ./Juno-palenight-v40 /home/$USER/.themes
cp -rf ./DeepOcean-B /home/$USER/.themes
cp -rf ./gtk-3.0/* /home/$USER/.config/gtk-3.0/
mkdir -p /home/$USER/.config/gtk-4.0/
cp -rf ./gtk-4.0/* /home/$USER/.config/gtk-4.0/
mkdir -p /home/$USER/.icons
cp -rf Tela-circle-purple /home/$USER/.icons
# ----------------------------------- fish tweaks --------------------------------
sudo dnf in fish starship exa util-linux-user
sudo cp -rf ./.bashrc /home/$USER/.bashrc
mkdir -p /home/$USER/.local/share/fonts
mkdir -p /home/$USER/.config/fish
cp -rf "Hack Regular Nerd Font Complete.ttf" /home/$USER/.local/share/fonts
cp -rf ./starship.toml /home/$USER/.config
cp -rf ./config.fish /home/$USER/.config/fish/
curl -Lo ~/.config/fish/conf.d/done.fish --create-dirs https://raw.githubusercontent.com/franciscolourenco/done/master/conf.d/done.fish
curl -L https://get.oh-my.fish | fish
omf install bang-bang 
# ----------------------------------- fix fish missing files --------------------------------
sudo mkdir -p /usr/share/doc/find-the-command/
sudo touch /usr/share/doc/find-the-command/ftc.bash
sudo touch /usr/share/doc/find-the-command/ftc.fish
# ----------------------------------- apply fish tweaks --------------------------------
sudo chsh -s /usr/bin/fish
# ----------------------------------- set up Kvantum & qt5ct --------------------------------
sudo dnf in kvantum qt5ct qt5-qtstyleplugins

sudo nano /etc/enviroment
# -- QT_QPA_PLATFORMTHEME=qt5ct

sudo nano /home/$USER/.profile
# -- export QT_QPA_PLATFORMTHEME=qt5ct
# -- export QT_STYLE_OVERRIDE=qt5ct" >> ~/.profile


cp -rf Nordic-bluish-solid /home/$USER/.config/Kvantum
sudo dnf in plasma-desktop # apply nordic theme usw qt5ct set kde
cp -rf Nordic-bulish ~/.local/share/plasma/desktoptheme/
# -------------------------------------- Gnome Terminal theming ----------------------------------------------------------
#Terminal Theme: Text = #CCD1FF ; Backgroudcolor = #34324a ; integrated Theme = Tango ; form of input makr = line
# ----------------------------------- installation of mutter-rounded/-settings --------------------------------
git clone https://github.com/yilozt/mutter-rounded
cd ./mutter-rounded/fedora
sh package.sh

sudo curl -sL https://dl.yarnpkg.com/rpm/yarn.repo -o /etc/yum.repos.d/yarn.repo
sudo dnf in yarn -y 

cd ~/rpmbuild/RPMS/x86_64/
sudo dnf upgrade mutter
sudo rpm --reinstall mutter-*

git clone https://github.com/yilozt/mutter-rounded-setting
cd ./mutter-rounded-setting
./install

cp mutter_settings.js (xdg-user-dir DOCUMENTS)
# ------------------------------
gjs dist/mutter_settings.js # Command to open
# ------------------------------------------------------------------------------------------------------------------- Additional
# Installation Vivaldi
sudo dnf in vivaldi
# Installation Heroic Games Launcher
dnf copr enable atim/heroic-games-launcher -y 
sudo dnf in heroic-games-launcher -y
# installation polymc
sudo dnf copr enable sentry/polymc -y   
sudo dnf install polymc -y
# RPM-REPO Installation vscodium
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
sudo dnf install codium -y
# Installation virt-manager 'migrations'
sudo dnf install @virtualization -y
sudo nano /etc/libvirt/libvirtd.conf
 # -- unix_sock_group = "libvirt"
 # -- unix_sock_rw_perms = "0770"
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
sudo usermod -a -G libvirt $(whoami)
# Installation onlyoffice YUM_REPO
sudo yum install https://download.onlyoffice.com/repo/centos/main/noarch/onlyoffice-repo.noarch.rpm
sudo yum install epel-release
sudo yum install onlyoffice-desktopeditors -y

