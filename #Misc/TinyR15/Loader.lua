--[[
# This script only works with the R15 body type.
# The script execution can be detected by games serversided.
# If the script isn't working you might need to set heigher values depanding on how long-
does it take to your character to fully load once it spawns. (I recommend to use 1.1 multipliers)

Avatar scale settings to become small as possible:

Body Type: 0%
Height: 90%
Width: 70%
Head: 95%
Proportions: 0%

--]]

--//Settings
getfenv().ToRemove = {
    {"BodyTypeScale",0.5 * 1.0},
    {"BodyWidthScale",1 * 1.0},
    {"BodyDepthScale",1 * 1.0}
}

getfenv().AlwaysOn = true --// Enabling this will make you smaller after character reset.

--//Loadstring
loadstring(game:HttpGet('https://raw.githubusercontent.com/NoclippyT/Scripts/main/%23Misc/TinyR15/Main.lua'))()
