#!/bin/sh

rocketlaunch_dir=`pwd` #from https://unix.stackexchange.com/a/52919/470623
flouser=$(logname)

echo "Installing shell-genie..."
cd include/shell-genie
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/shell-genie.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
#chmod +x install.sh && ./install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -rf colors
#rm -rf src
#rm -f INSTALL.md
#rm -f LICENSE
#rm -f readme.md
#rm -f screenshot.png
python3 -m pip install --user --break-system-packages pipx
python3 -m pipx ensurepath
sudo apt install python3-full
pipx install shell-genie
cd "$rocketlaunch_dir"

echo "Installing neurus-core..."
sudo cp -f neurus /usr/bin/neurus

#if [ ! -e /usr/lib/ethgas ]; then sudo mkdir /usr/lib/ethgas; fi
#sudo cp -f gas-pump.svg /usr/lib/ethgas/gas-pump.svg
#sudo cp -f gas-pump-symbolic.svg /usr/share/icons/hicolor/scalable/status/gas-pump-symbolic.svg

echo "Installing icon..."
cp include/neurus.svg /usr/share/icons/hicolor/scalable/apps/
#sudo gtk-update-icon-cache /usr/share/icons/Floflis/ -f
sudo gtk-update-icon-cache /usr/share/icons/hicolor/ -f

cat > /usr/share/applications/neurus.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Neurus Assistant
Comment=Your system-wide personal assistant! Powered by OpenAI's GPT-3.5
# Translators: Do NOT translate or transliterate this text (this is an icon file name)!
Icon=neurus
Exec=gnome-terminal --tab --title="Neurus " -- /bin/sh -c 'neurus'
Terminal=false
Hidden=false
NoDisplay=false
#DBusActivatable=true
StartupNotify=true
Categories=GNOME;GTK;Utility;X-GNOME-Utilities;
# Translators: Search terms to find this application. Do NOT translate or localize the semicolons! The list MUST also end with a semicolon!
Keywords=personal;assistant;gpt;gpt3;gpt35;chatgpt;
#X-Purism-FormFactor=Workstation;Mobile;
#X-Ubuntu-Gettext-Domain=org.gnome.Characters
EOF

installfail(){
   echo "Installation has failed."
   exit 1
}

if [ -f /usr/bin/neurus ];then
   echo "- Turning neurus-core into an executable..."
   sudo chmod +x /usr/bin/neurus
   if ethgas babyisalive; then echo "Done! Running 'neurus' command as example to use it:" && (neurus &);exit 0; else installfail; fi
   else
      installfail
fi
