function onCreate()
	precacheImage('sp')
end

function onEvent(name, value1, value2)
    if name == "Spatula Mechanic" then
	makeAnimatedLuaSprite('sp','sponge tears/sp', 0, 0)
	setLuaSpriteScrollFactor('sp',0,0)
	addAnimationByPrefix('sp','sp','sp',20,true)
	addLuaSprite('sp',true)
	objectPlayAnimation('sp','sp',false)
    setObjectCamera('sp', 'other');
    runTimer('wait', 9);
    end
    end
    
    function onTimerCompleted(tag, loops, loopsleft)
    if tag == 'wait' then
    removeLuaSprite('sp', true);
    end
    end