Aztter for Ubuntu Phone
=======================

twitter client for Ubuntu Phone

# Build
※ if you can't build project though you do referencing it , sorry.

1. git clone https://github.com/yuntan/Aztter-for-Ubuntu-Phone.git
1. cd Aztter-for-Ubuntu-Phone
1. git checkout v0.1
1. git submodule init
1. git submodule update
1. cp testkeys.h aztterplugin/aztterkeystore.h
1. cd KQOAuth
1. /usr/lib/x86_64-linux-gnu/qt5/bin/qmake
1. make
1. cd ../aztterplugin
1. mv aztterplugin.pro aztterplugin.pro.bac
1. cat aztterplugin.pro.bac | sed -e '/\ty.h/d' | sed -e '/\te.h/d' | sed -e '/\tk.h/d' | sed -e '/aztterkeystore.cpp/d' >aztterplugin.pro
1. /usr/lib/x86_64-linux-gnu/qt5/bin/qmake
1. make
1. cd ..
1. LD_LIBRARY_PATH=./lib qmlscene main.qml

# About this software
This software is distributed under the GNU lesser general public license version 3.  

__The following are used__  
Qt LGPL  
Ubuntu SDK (LGPL v3 2012 Canonical Ltd.)  
Empty.qml from Ubuntu SDK (LGPL v3 2012 Canonical Ltd.)  
kQOAuth (LGPL v2.1 Johan Paul)  

