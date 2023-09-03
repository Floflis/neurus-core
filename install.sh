#!/bin/sh

echo "Installing neurus-core..."

sudo cp -f neurus /usr/bin/neurus

#if [ ! -e /usr/lib/ethgas ]; then sudo mkdir /usr/lib/ethgas; fi
#sudo cp -f gas-pump.svg /usr/lib/ethgas/gas-pump.svg
#sudo cp -f gas-pump-symbolic.svg /usr/share/icons/hicolor/scalable/status/gas-pump-symbolic.svg

echo "Installing icon..."
cp include/neurus.svg /usr/share/icons/hicolor/scalable/apps/
#sudo gtk-update-icon-cache /usr/share/icons/Floflis/ -f
sudo gtk-update-icon-cache /usr/share/icons/hicolor/ -f

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
