#! /bin/bash

CONFIG="$HOME/.config/kosmos-welcome.conf"
WELCOME=/usr/share/kosmos-welcome/welcome.qml

if [ -f "$CONFIG" ]; then
	FLAG=$( grep -A1 "dontShowAgain" "$CONFIG" | tail -n1 | cut -d'=' -f2 )
else
	FLAG=false
fi

if [ "$FLAG" = "false" ]; then
	QT_QPA_PLATFORMTHEME=generic /usr/lib/qt6/bin/qml --style Fusion $WELCOME
	touch $FLAG
fi
