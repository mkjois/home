makepkg -sf
exit
pacorph
less .bash_aliases 
sudo pacorph
sudo powerpill -Qdtq
pacclean
su
makepkg -s
cd /build
ls -ld
ls -l
sudo chgrp -R build broadcom-wl-dkms
cd broadcom-wl-dkms/
makepkg -s
sudo chmod -R g+w .
makepkg -s
ls
exit
systemctl --type=service
sudo systemctl disable slim
journalctl
sudo systemctl status slim
less /etc/slim.conf 
sudo systemctl disable slim.service
systemctl --type=service
sudo systemctl disable multi-user.target
less /etc/systemd/system/display-manager.service
sudo systemctl enable slim.service
less /etc/systemd/system/display-manager.service
reboot
sudo systemctl --type=service
sudo systemctl status lightdm
sudo systemctl start dhcpcd.service
pacin lightdm-gtk-greeter
sudo systemctl disable lightdm.service
sudo systemctl enable lightdm.service
reboot
sudo systemctl disable lightdm.service
pacrm lightdm-gtk-greeter
pacrm lightdm
pacin lxde
sudo systemctl start dhcpcd.service
pacin lxde
ping -c2 google.com
sudo systemctl --type=service
ip link
ip link
ip link
pacin lxde
sudo systemctl enable lxdm.service
reboot
which nmcli
sudo systemctl --type=service
sudo systemctl start NetworkManager.service
sudo systemctl enable NetworkManager.service
ping -c2 google.com
pacorph
pacclean
paccleanall
df -h
exit
sudo systemctl --type=service
ls -a
ls dotfiles/x11
ls dotfiles/x11 -a
mv .Xauthority dotfiles/x11
ln -s dotfiles/x11/.Xauthority 
vi .bashr
vi .bashrc

cd .config
ls
cd lxterminal/
ls
vi lxterminal.conf 
exit
vi .config/lxterminal/lxterminal.conf 
exit
exit
ls
source .bashrc
source ~/.bashrc
ls sockets
ssh tetra
ssh upage-api-dev
ssh upage-api-dev
exit
pacin gvim
which gvim
gvim a.py
vim a.py
ls
la
less .face
mv .themes dotfiles/themes
mv .icons dotfiles/icons
ln -s dotfiles/themes .themes
ln -s dotfiles/icons .icons
mkdir dotfiles/vim
mv .viminfo dotfiles/vim
ln -s dotfiles/vim/.viminfo 
curl -O http://192.168.1.11:8888/.vimrc
la
mv .vimrc dotfiles/vim
ln -s dotfiles/vim/.vimrc
la
mv .face .cinnamon
ln -s dotfiles/cinnamon/.face 
la
which git
git config --global user.name "Manny Jois"
git config --global user.email "m.k.jois@gmail.com"
la
mkdir dotfiles/git
mv .gitconfig dotfiles/git/
ln -s dotfiles/git/.gitconfig 
cd /build
ls
rm -rf command-not-found/
ls
curl -L -O https://aur.archlinux.org/packages/vi/vim-pathogen/vim-pathogen.tar.gz
ls
tar -xvf vim-pathogen.tar.gz 
rm vim-pathogen.tar.gz 
cd vim-pathogen/
ls -l ..
cd ..
clear
ls
chgrp -R build vim-pathogen
chmod -R g+w vim-pathogen/
ls -l
ls -ld
chown -R root pm2ml/ powerpill/ vim-pathogen/
sudo chown -R root pm2ml/ powerpill/ vim-pathogen/
ls -l
cd ..
getfacl build
man setfacl
cd /build
ls
touch asdf
ls -l
rm asdf
sudo setfacl -Rdm u:root:rwx /build
sudo setfacl -Rdm g:build:rwx /build
getfacl /build
touch asdf
ls -l
ll
ll -d /build
getfacl /build
rm asdf
sudo chmod g+s /build
getfacl /build
touch asdf
ll
sudo chmod u+s /build
rm asdf
man setfacl
sudo setfacl -b /build
getfacl build
getfacl /build
ll
touch asdf
ll
mkdir foo
ll
rmdir foo
rm asdf
man setfacl
sudo setfacl -Rd u:root:rwx g:build:rwx /build
sudo setfacl -Rd u:root:rwx /build
sudo setfacl -Rdm u:root:rwx /build
sudo setfacl -Rdm g:build:rwx /build
getfacl /build
touch asdf
mkdir foo
ll
rm foo
rmdir foo
rm asdf
sudo chmod u-s /build
ll
touch asdf
mkdir foo
ll
rmdir foo
rm asdf
cd vim-pathogen/
l
makepkg -s
ls
pacpk vim-pathogen-2.3-2-any.pkg.tar.xz 
cd
la
vim a.py
la
less .viminfo
la
rm .viminfo .lesshst
ln -s dotfiles/vim/.viminfo 
ln -s dotfiles/less/.lesshst 
less .vimrc
la
ls dotfiles/less -a
rm -rf dotfiles/less
solarized
solar
dotfiles
dot
eog
ls /usr/bin/eog
find . -name "*pathogen*"
cd /build
pacrm vim-pathogen
ls
rm -rf vim-pathogen/
ls
pacorph
pacclean
pacprune
leafs
gpicview
df
df -h
cd
ls dotfiles
la
ln -s dotfiles/vim .vim
cd .vim
mkdir autoload bundle
curl -LSso autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd autoload
ls
pwd
man curl
which wget
pacin wget
man wget
rmdir bundle colors
cd ..
rmdir bundle colors
ls
wget -r http://192.168.1.11:8888/colors/
ls
mv 192.168.1.11\:8888/ colors
ls
ls colors
ls colors/colors
rm -rf colors
wget -r http://192.168.1.11:8888/colors/ -o colors
ls
ls 192.168.1.11\:8888/colors/
rm colors
mv 192.168.1.11\:8888/colors .
rmdir 192.168.1.11\:8888/
ls
rm colors/index.html 
wget -r http://192.168.1.11:8888/bundle/
ls
mv 192.168.1.11\:8888/bundle/ .
rmdir 192.168.1.11\:8888/
cd bundle
ls
rm index.html
cd
la
vim a.coffee
vim a.py
gvim a.coffee
cd .vim/bundle
l
cd vim-less/
git status
cd ..
find -R . -name index.html
find -r . -name index.html
man find
find . -type f -name "index.html"
find . -type f -name "index.html" -delete
find . -type f -name "index.html"
l
cd rust.vim/
git status
cd ../vim-ansible-yaml/
git staus
git status
cd ../vim-better-whitespace/
git status
cd ../vim-coffee-script/
git status
cd ../vim-colors-solarized/
git status
cd ../vim-less
git status
cd ../vim-markdown/
git status
cd
la
rm dotfiles/vim/.viminfo 
vim a.py
vim a.py
echo $TERM
which xterm
pacin terminator
ls
git clone git@github.com/ghuntley/terminator-solarized.git
l
git clone git@github.com:ghuntley/terminator-solarized.git
pacin openssh
which ssh-keygen
la
mkdir dotfiles/ssh
ln -s dotfiles/ssh .ssh
ssh-keygen
ls
la
cd .ssh
ls
less /etc/ssh/ssh_config
vi ~/.vimrc
vim ~/.vimrc
source ~/.vimrc
cd
vim a.py
gvim a.py
cd .ssh
ls
which terminator
pacrm terminator
pacclean
pacprune
vim /etc/ssh/ssh_config
gvim /etc/ssh/ssh_config
gvim /etc/ssh/ssh_config
curl -O http://192.168.1.11:8888/config
curl -O http://192.168.1.11:8888/awskeys.csv
ls
vim config
curl -O http://192.168.1.11:8888/id_tetra.pub
curl -O http://192.168.1.11:8888/id_upage.pub
curl -O http://192.168.1.11:8888/mjubuntu.pem
mv mjubuntu.pem mjarch.pem
cat config
ssh tetra
ssh tetra
ssh upage-api-dev
ll
chmod 400 mjarch.pem
ssh upage-api-dev
curl -w "\n" -L http://ec2-54-148-75-84.us-west-2.compute.amazonaws.com:5056/d/ping
curl -w "\n" -L http://ec2-54-148-75-84.us-west-2.compute.amazonaws.com:5056/d/ping -k
vim config
ls
ssh tetra
ls
mkdir sockets
ssh tetra
ssh tetra
cd ..
gvim a.py
python
python a.py
which python3
which python2
which python2.7
which pip
ls
gvim a.py
gvim a.py
gvim a.py
pip
pacin python-pip
which pip
pip
chrome
google-chrome
exit
exit
gvim /etc/X11/xorg.conf.d/50-synaptics.conf 
sudo gvim /etc/X11/xorg.conf.d/50-synaptics.conf 
exit
exit
echo $TERM
export TERM=lxterminal
$TERM
exit
exit
exit
ls
exit
which gsettings
which lxterminal
man lxterminal
lxterminal
cd .vim/bundle
lxterminal
man lxterminal
man lxterminal
lxterminal -l
gsettings set org.cinnamon.desktop.default-applications.terminal exec /usr/bin/lxterminal
exit
exit
cd .vim/bundle
lxterminal -w ~
lxterminal --working-directory=~
gsettings set org.cinnamon.desktop.default-applications.terminal exec-arg "--working-directory=~"
exit
ls
cd
l
rm a.py
mkdir -p docs/misc
cd docs/misc
curl -O http://192.168.1.11:8888/chrome-bookmarks.html
ls
exit
cd /build
ls
curl -L -O https://aur.archlinux.org/packages/go/google-chrome/google-chrome.tar.gz
tar -xvf google-chrome.tar.gz 
rm google-chrome.tar.gz 
cd google-chrome/
l
ls -l ..
makepkg -s
cd
cd /build/google-chrome/
ls
pacpk google-chrome-42.0.2311.135-1-x86_64.pkg.tar.xz 
cd
cd docs/misc
cd ..
rm -rf misc
ls
la
pwd
wget -r http://192.168.1.11:8888/
ls
ls 192.168.1.11\:8888/
mv 192.168.1.11\:8888/ misc
ls
cd misc
ls
rm index.html
exit
sudo gvim /etc/X11/xorg.conf.d/50-synaptics.conf 
exit
gvim .bash_enviros 
la
mkdir dotfiles/python dotfiles/gnome
mv .python_history dotfiles/python
ln -s dotfiles/python/.python_history 
rmdir dotfiles/gnome
mv .gnome dotfiles/gnome
ln -s dotfiles/gnome .gnome
la
node
npm
pacin nodejs
which node
which npm
man npm
pacprune
pacclean
sudo pip install numpy scipy
lspci -k | grep hda
lspci -k | grep ac97
ls /etc/modprobe.d/
sudo gvim /etc/modprobe.d/audio_powersave.conf
sudo gvim /etc/udev/rules.d/51-bluetooth.rules
sudo rm /etc/udev/rules.d/51-bluetooth.rules 
sudo systemctl start rfkill-block@bluetooth.service
sudo systemctl enable rfkill-block@bluetooth.service
rfkill list
sudo gvim /etc/sysctl.d/laptop.conf
sudo gvim /etc/sysctl.d/dirty.conf
sudo gvim /etc/udev/rules.d/70-disable_wol.rules
sudo gvim /etc/udev/rules.d/70-wifi_powersave.rules
sudo gvim /boot/loader/entries/arch.conf 
sudo gvim /etc/udev/rules.d/99-hibernate.rules
ls /sys
ls /sys/power
sudo vim /sys/power/image_size 
cat /sys/power/image_size 
sudo gvim /boot/loader/entries/arch.conf 
sudo gvim /etc/mkinitcpio.conf 
mkinitcpio -p linux
sudo mkinitcpio -p linux
sudo systemctl --type=service
sudo systemctl status systemd-backlight
sudo systemctl status systemd-backlight@backlight:intel_backlight
lsusb
lspci
lspci | grep cam
lsusb -v
lsusb
exit
