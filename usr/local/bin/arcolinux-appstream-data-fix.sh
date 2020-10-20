#!/bin/bash
#
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	Erik Dubois
# Website 	: 	http://www.erikdubois.be
##################################################################################################################
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

#echo "Fix for icons not showing up in pamac-aur"

sudo pacman -S appstream --noconfirm --needed
zcat /usr/share/app-info/xmls/community.xml.gz | sed 's|<em>||g;s|<\/em>||g;' | gzip > "new.xml.gz"
sudo mv new.xml.gz /usr/share/app-info/xmls/community.xml.gz
sudo appstreamcli refresh-cache --force