function onCreate()

	makeLuaSprite('theBg','wall-woofy',-280,-130)
	addLuaSprite('theBg',false)
	setLuaSpriteScrollFactor('theBg', 0.9, 0.9)

end

function onBeatHit(   )-- for every beat
	
end

function onStepHit(   )-- for every step
	-- body
end

function onUpdate(   )
	-- body
end

function onEvent(name,value1,value2)
	if name == 'Play Animation' then 
		
		if value1 == '1' then
			setProperty('theBg.visible', false);	
			makeLuaSprite('theBg','wall-woofy-bad',-280,-130)
			addLuaSprite('theBg',false)
			setLuaSpriteScrollFactor('theBg', 0.9, 0.9)	
		end
	end
end
