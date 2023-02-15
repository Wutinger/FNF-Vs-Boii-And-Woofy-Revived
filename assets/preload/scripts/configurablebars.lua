--1F1D on Gamebanana made this script!

function onCreate()

--SHAPES & SIZES HERE

Thickness = 0.05 --Mess with these values until you get what you want.
Border = 0.03
Length = 1.965
barX = 300
barY = 12.5

--TEXT CONFIG HERE

textX = 600
textY = 6.5 --Change "barY" to a number for more positioning options
textSize = 22
textColor = 'ffffff' --These colors must be in hex codes


--COLORS & SHADING HERE

fillingBarColor = '00ff00' --These colors must be in hex codes
emptyBarColor = '000000'
borderColor = '2e2e2e'

--Color shading options include "color", "colorShaded", "colorShadedReverse", "colorShadedDown", "colorShadedUp",

makeLuaSprite('border', 'colorShadedDown', barX - Border * 175, barY - Border * 165)
makeLuaSprite('emptyBar', 'color', barX, barY)
makeLuaSprite('fillBar', 'colorShadedDown', barX, barY)

addLuaSprite('border', true)
addLuaSprite('emptyBar', true)
addLuaSprite('fillBar', true)

setObjectCamera('border', 'hud')
setObjectCamera('emptyBar', 'hud')
setObjectCamera('fillBar', 'hud')

scaleObject('border', Length + Border, Thickness + Border)
scaleObject('emptyBar', Length, Thickness)
scaleObject('fillBar', Length, Thickness)

doTweenColor('borderColor', 'border', borderColor, 0.01)
doTweenColor('emptyBarColor', 'emptyBar', emptyBarColor, 0.01)
doTweenColor('fillBarColor', 'fillBar', fillingBarColor, 0.01)

if Border == 0 then
removeLuaSprite('border', true)
end
end

function onCreatePost()

makeLuaText("nametext", songName, 0, textX, textY)
setTextSize('nametext',  textSize)
setTextColor('nametext', textColor)
setTextAlignment('nametext', 'center')
addLuaText("nametext")

setProperty('timeBarBG.visible', false)
setProperty('timeBar.visible', false)
setProperty('timeTxt.visible', false)

end

function onUpdate()
setTextString('nametext', getProperty('timeTxt.text'))
scaleObject('fillBar', Length * getProperty("songPercent"), Thickness)
end