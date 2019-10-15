import xbmcaddon
import xbmcgui
import os
import commands

output = commands.getoutput('ps -A | grep -v grep | grep -c hyperiond')
		
if output[0] == "0":
        cmd     = "/storage/hyperion/bin/hyperiond.sh /storage/.config/hyperion.config.json </dev/null >/dev/null 2>&1 &"
        line    = "Lights On"
else:
        cmd     = "killall hyperiond"
        line    = "Lights Off"

os.system(cmd)
xbmc.executebuiltin('Notification(Hyperion,%s,2000)' % line)
