local allowCountdown = false
function onCreatePost()
   makeLuaText("message", "woofy's lullaby | Original song by Adam McHummus", 500, 30, 50)
   setTextAlignment("message", "left")
   addLuaText("message")

   makeLuaText("engineText", "Left Unchecked - Vs Boii and Woofy V5", 500, 30, 30)
   setTextAlignment("engineText", "left")
   --addLuaText("engineText")
   setProperty('message.y', 680)
   --setProperty('engineText.y', 660)
end

function onSongStart()
	noteTweenX('oppo0', 0, -1000, 1.5, 'quartInOut')
	noteTweenX('oppo1', 1, -1000, 1.5, 'quartInOut')
	noteTweenX('oppo2', 2, -1000, 1.5, 'quartInOut')
	noteTweenX('oppo3', 3, -1000, 1.5, 'quartInOut')
	noteTweenAngle('opporotate0', 0, 360, 1, 'quartInOut')
	noteTweenAngle('opporotate1', 1, 360, 1, 'quartInOut')
	noteTweenAngle('opporotate2', 2, 360, 1, 'quartInOut')
	noteTweenAngle('opporotate3', 3, 360, 1, 'quartInOut')
	noteTweenX('play0', 4, 415, 1, 'quartInOut')
	noteTweenX('play1', 5, 525, 1, 'quartInOut')
	noteTweenX('play2', 6, 635, 1, 'quartInOut')
	noteTweenX('play3', 7, 745, 1, 'quartInOut')
	noteTweenAngle('playrotate0', 4, 360, 1, 'quartInOut')
	noteTweenAngle('playrotate1', 5, 360, 1, 'quartInOut')
	noteTweenAngle('playrotate2', 6, 360, 1, 'quartInOut')
	noteTweenAngle('playrotate3', 7, 360, 1, 'quartInOut')
end