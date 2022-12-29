#!/bin/bash
#set -e
##################################################################################################################
# Author    : Erik Dubois
# Website   : https://www.erikdubois.be
# Website   : https://www.alci.online
# Website   : https://www.ariser.eu
# Website   : https://www.arcolinux.info
# Website   : https://www.arcolinux.com
# Website   : https://www.arcolinuxd.com
# Website   : https://www.arcolinuxb.com
# Website   : https://www.arcolinuxiso.com
# Website   : https://www.arcolinuxforum.com
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################
#tput setaf 0 = black
#tput setaf 1 = red
#tput setaf 2 = green
#tput setaf 3 = yellow
#tput setaf 4 = dark blue
#tput setaf 5 = purple
#tput setaf 6 = cyan
#tput setaf 7 = gray
#tput setaf 8 = light blue
##################################################################################################################

# reset - commit your changes or stash them before you merge
# git reset --hard - personal alias - grh

# checking if I have the latest files from github
echo "Checking for newer files online first"
git pull

workdir=$(pwd)

echo "Get the original samba file from samba github"
wget https://gitlab.com/samba-team/samba/-/raw/master/examples/smb.conf.default -O $workdir/etc/samba/smb.conf.original

echo "getting mirrorlist ArchLinux"
wget https://raw.githubusercontent.com/arcolinux/arcolinuxl-iso/master/archiso/airootfs/etc/pacman.d/mirrorlist -O $workdir/usr/local/share/arcolinux/pacman.d/mirrorlist

echo "getting default grub file"
wget https://raw.githubusercontent.com/arcolinux/arcolinuxl-iso/master/archiso/airootfs/etc/default/grub -O $workdir/usr/local/share/arcolinux/grub/grub

echo "getting latest .bashrc"
wget https://raw.githubusercontent.com/arcolinux/arcolinux-root/master/etc/skel/.bashrc-latest -O $workdir/usr/local/share/arcolinux/.bashrc

echo "getting latest .zshrc"
wget https://raw.githubusercontent.com/arcolinux/arcolinux-zsh/master/etc/skel/.zshrc -O $workdir/usr/local/share/arcolinux/.zshrc

echo "getting latest config.fish"
wget https://raw.githubusercontent.com/arcolinux/arcolinux-fish/main/etc/skel/.config/fish/config.fish -O $workdir/usr/local/share/arcolinux/config.fish

echo "getting latest NEW /etc/sddm.conf"
wget https://raw.githubusercontent.com/arcolinux/arcolinuxl-iso/master/archiso/airootfs/etc/sddm.conf -O $workdir/usr/local/share/arcolinux/sddm/sddm.conf

wget https://raw.githubusercontent.com/arcolinux/arcolinuxl-iso/master/archiso/airootfs/etc/sddm.conf.d/kde_settings.conf -O $workdir/usr/local/share/arcolinux/sddm.conf.d/kde_settings.conf
FIND="Session=xfce"
REPLACE="#Session="
sed -i "s/$FIND/$REPLACE/g" $workdir/usr/local/share/arcolinux/sddm.conf.d/kde_settings.conf

FIND="User=liveuser"
REPLACE="#User="
sed -i "s/$FIND/$REPLACE/g" $workdir/usr/local/share/arcolinux/sddm.conf.d/kde_settings.conf

echo "getting latest arcolinux-mirrorlist"
wget https://raw.githubusercontent.com/arcolinux/arcolinux-mirrorlist/master/etc/pacman.d/arcolinux-mirrorlist -O $workdir/usr/local/share/arcolinux/pacman.d/arcolinux-mirrorlist

echo "getting latest /etc/pacman.conf"
wget https://raw.githubusercontent.com/arcolinux/arcolinuxl-iso/master/archiso/airootfs/etc/pacman.conf -O $workdir/usr/local/share/arcolinux/pacman.conf

echo "getting latest /etc/nsswitch.conf"
wget https://raw.githubusercontent.com/arcolinux/arcolinuxl-iso/master/archiso/airootfs/etc/nsswitch.conf -O $workdir/usr/local/share/arcolinux/nsswitch.conf

# Below command will backup everything inside the project folder
git add --all .

# Give a comment to the commit if you want
echo "####################################"
echo "Write your commit comment!"
echo "####################################"

read input

# Committing to the local repository with a message containing the time details and commit text

git commit -m "$input"

# Push the local files to github

if grep -q main .git/config; then
	echo "Using main"
		git push -u origin main
fi

if grep -q master .git/config; then
	echo "Using master"
		git push -u origin master
fi

echo "################################################################"
echo "###################    Git Push Done      ######################"
echo "################################################################"
