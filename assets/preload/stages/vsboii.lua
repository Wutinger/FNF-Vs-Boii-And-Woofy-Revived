function onCreate()
	-- background shit
	makeLuaSprite('stageback', 'brown', -590, -180);
	setLuaSpriteScrollFactor('stageback', 0.9, 0.9);
	addLuaSprite('stageback', false);
	
	makeLuaSprite('stagefront', 'wall', -650, 600);
	setLuaSpriteScrollFactor('stagefront', 0.9, 0.9);
	scaleObject('stagefront', 1.1, 1.1);
    addLuaSprite('stagefront', false);
end
function onEvent(name,value1,value2)
	if name == 'Play Animation' then 
		
		if value1 == '2' then
			setProperty('stageback.visible', false);
			setProperty('stagefront.visible', false);		
		end

		if value1 == '1' then
	                setProperty('stageback.visible', true);
					setProperty('stagefront.visible', true);
				end
	end
end