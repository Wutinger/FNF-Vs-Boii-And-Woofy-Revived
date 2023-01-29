local tweening = 0
local tweening2 = 0
local note = 0
local note2 = 0
local safeswitch = 1
local originx = 128
local originy = 64

function onCreate()
		originx = getPropertyFromClass("openfl.Lib","application.window.x")
		originy = getPropertyFromClass("openfl.Lib","application.window.y")
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	safeswitch = 0
		if direction == 0 then
			note = 0
			tweening = 40
		elseif direction == 1 then
			note2 = 1
			tweening2 = 40
		elseif direction == 2 then
			note2 = 2
			tweening2 = 40
		elseif direction == 3 then
			note = 3
			tweening = 40
		end
end

function onUpdate()
	if safeswitch == 0 then
	if tweening >= 0 then
		if note == 0 then
				setPropertyFromClass("openfl.Lib", "application.window.x", originx - tweening)
			elseif note == 3 then
				setPropertyFromClass("openfl.Lib", "application.window.x", originx + tweening)
		end
		tweening = tweening - 1
	else
		tweening = 0
	end
	if tweening2 >= 0 then
		if note2 == 1 then
				setPropertyFromClass("openfl.Lib", "application.window.y", originy + tweening2)
			elseif note2 == 2 then
				setPropertyFromClass("openfl.Lib", "application.window.y", originy - tweening2)
		end
		tweening2 = tweening2 - 1
	else
		tweening2 = 0
	end
	if tweening == 0 and tweening2 == 0 then
		safeswitch = 1
	end
	end
end