import xbmcaddon
import xbmcgui
import os
import commands

output = commands.getoutput('systemctl is-active hyperion')

if output == "active":
        cmd     = "sudo systemctl stop hyperion"
        line    = "Lights Off"
else:
        cmd     = "sudo systemctl start hyperion"
        line    = "Lights On"

os.system(cmd)
xbmc.executebuiltin('Notification(Hyperion,%s,2000)' % line)
