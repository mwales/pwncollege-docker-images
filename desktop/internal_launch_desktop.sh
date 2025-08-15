#!/bin/bash

FONT_PATH="/usr/share/fonts/X11/misc,/usr/share/fonts/X11/75dpi,/usr/share/fonts/X11/100dpi,/usr/share/fonts/X11/Type1,/usr/share/fonts/X11/encodings"
vncserver -localhost no -geometry 1280x800 -SecurityTypes None --I-KNOW-THIS-IS-INSECURE -fg \
  -xstartup /usr/bin/startxfce4 -fp "$FONT_PATH"
