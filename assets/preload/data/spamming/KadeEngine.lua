local bscore = 0
local songended = false
local noteCreated = false
local isPixel = false

function onCreatePost()
    setProperty("infoTxtKade.y", -500)
    if getPropertyFromClass('PlayState', 'isPixelStage') then 
		isPixel = true
	end

    setProperty('timeBarBG.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('scoreTxt.visible', false)

    local timeY = 20

    if downscroll then
        timeY = 690
    end

    local songNameNoSpace = songName
    local difficultyNameUpper = string.upper(difficultyName:sub(1, 1)) .. difficultyName:sub(2, #difficultyName)

    for i = 1, #songName do
        if songName:sub(i, i) == " " then
            songNameNoSpace = songNameNoSpace:sub(1, i - 1) .. "-" .. songNameNoSpace:sub(i + 1, #songName)
        end
    end

    makeLuaText("scoreTxtKade", "NPS: 0 | Score:0 | Combo Breaks:0 | Accuracy:0% | N/A", 0, getProperty('scoreTxt.x') + 362.5, getProperty('scoreTxt.y') + 10)
    setTextSize('scoreTxtKade', 16)
    setTextFont("scoreTxtKade", "kade.ttf")
    setTextAlignment('scoreTxtKade', 'LEFT')
    setObjectOrder('scoreTxtKade', 40)

    makeLuaText("infoTxtKade", songNameNoSpace .. " " .. difficultyNameUpper .. " - PSYCH ENGINE CUSTOM BUILD - FNF", 0, 10, 690)
    setTextSize('infoTxtKade', 16)
    setTextAlignment('infoTxtKade', 'LEFT')
    setTextFont("infoTxtKade", "kade.ttf")
    setObjectOrder('infoTxtKade', 40)

    makeLuaText("msTxtKade", "69.42ms", 0, 520, 350)
    setProperty('msTxtKade.alpha', 0)
    setTextSize('msTxtKade', 17)
    setTextColor('msTxtKade', '00FFFF')
    setTextAlignment('msTxtKade', 'CENTER')
    setTextFont("msTxtKade", "kadems.otf")

    if isPixel then
        setProperty('msTxtKade.y', 400)
    end

    if not hideHud then
        if not hideTime then
            addLuaText("timeTxtKade")
        end

        addLuaText("scoreTxtKade")
        addLuaText("infoTxtKade")
    end

    addLuaText("msTxtKade")
end

function onCreate()
    local Y1 = 19.95
    local Y2 = 24.25

    if downscroll then
        Y1 = 689.95
        Y2 = 694.25
    end

end

local nps = 0
local noteHitted = false
local canRemove = true
local isbroNps = true
local willYouRemove = false

function goodNoteHit(id, noteData, noteType, isSustainNote)
    local strumTime = getPropertyFromGroup('notes', id, 'strumTime')
    local songPos = getPropertyFromClass('Conductor', 'songPosition')
    local rOffset = getPropertyFromClass('ClientPrefs','ratingOffset')
    
    local diff = strumTime - songPos + rOffset;
    local msDiffStr = string.format("%.3fms", -diff)

    if not isSustainNote then
        local rated = getRatingType(diff)

        if rated == "GOOD" then
            addScore(-150)
        elseif rated == "BAD" then
            addScore(-350)
        elseif rated == "SHIT" then
            addScore(-650)
            addMisses(1)
        end

        setTextString('msTxtKade', msDiffStr)
        setTextColor('msTxtKade', colorFromRating(diff))
        setProperty('msTxtKade.alpha', 1)
        doTweenAlpha('msAlpha', 'msTxtKade', 0, 0.5, "quartIn")
        runTimer('removeNoteHit', 1)

        if botPlay then
            setTextString('msTxtKade', msDiffStr .. " (BOT)")
            bscore = bscore + 350
        end

        noteHitted = false
        if canRemove then
            canRemove = false
            nps = nps - 1
        else
            nps = nps + 1
            willYouRemove = willYouRemove + 1

            if willYouRemove == true then
                willYouRemove = false
                canRemove = true
            else
                willYouRemove = true
            end
        end
    end

    runTimer('broNPS', 1)
    isbroNps = false
end

function onTimerCompleted(tag)
    if tag == "broNPS" then
        noteHitted = true
    end
end

function onStepHit()
    if noteHitted == true then
        nps = nps - 1
    else
        if curStep % 5 == 0 then
            nps = nps - 1
        end
    end     
end

function onBeatHit()
    if noteHitted == true then
        nps = nps - 2
    else
        nps = nps - 1
    end
end

function onGameOver()
    songended = true
    --setPropertyFromClass('lime.app.Application', 'current.window.title', "Friday Night Funkin': Psych Engine - Game Over")

    return Function_Continue
end

local lastTexture = ""

function onUpdate()
    if not inGameOver then
        local acc = rating * 100

        local note0 = false
        local note1 = false
        local note2 = false
        local note3 = false

        if isPixel then
            for i = 0, 3, 1 do
                local nTexture = "pNOTE_assets"
                local x = getPropertyFromGroup('opponentStrums', i, 'x')
                local y = getPropertyFromGroup('opponentStrums', i, 'y')
    
                if nTexture ~= "texture" then
                    setPropertyFromGroup('opponentStrums', i, 'visible', false)
    
                    if not noteCreated then
                        if i == 0 then
                            makeAnimatedLuaSprite("kadeLEFT", nTexture, x, y)
                            luaSpriteAddAnimationByPrefix('kadeLEFT', 'arrowIdle', 'arrowLEFT', 24, true)
                            setObjectCamera('kadeLEFT', 'hud')
                            setProperty('kadeLEFT.alpha', 0)
                            scaleObject('kadeLEFT', 0.7, 0.7)
                            setObjectOrder('kadeLEFT', 10)
                            addLuaSprite("kadeLEFT")
    
                            note0 = true
                        elseif i == 1 then
                            makeAnimatedLuaSprite("kadeDOWN", nTexture, x, y)
                            luaSpriteAddAnimationByPrefix('kadeDOWN', 'arrowIdle', 'arrowDOWN', 24, true)
                            setObjectCamera('kadeDOWN', 'hud')
                            setProperty('kadeDOWN.alpha', 0)
                            scaleObject('kadeDOWN', 0.7, 0.7)
                            setObjectOrder('kadeDOWN', 10)
                            addLuaSprite("kadeDOWN")
    
                            note1 = true
                        elseif i == 2 then
                            makeAnimatedLuaSprite("kadeUP", nTexture, x - 5.5, y - 1.5)
                            luaSpriteAddAnimationByPrefix('kadeUP', 'arrowIdle', 'arrowUP', 24, true)
                            setObjectCamera('kadeUP', 'hud')
                            setProperty('kadeUP.alpha', 0)
                            scaleObject('kadeUP', 0.7, 0.7)
                            setObjectOrder('kadeUP', 10)
                            addLuaSprite("kadeUP")
    
                            note2 = true
                        elseif i == 3 then
                            makeAnimatedLuaSprite("kadeRIGHT", nTexture, x - 2.5, y - 1.5)
                            luaSpriteAddAnimationByPrefix('kadeRIGHT', 'arrowIdle', 'arrowRIGHT', 24, true)
                            setObjectCamera('kadeRIGHT', 'hud')
                            setProperty('kadeRIGHT.alpha', 0)
                            scaleObject('kadeRIGHT', 0.7, 0.7)
                            setObjectOrder('kadeRIGHT', 10)
                            addLuaSprite("kadeRIGHT")
    
                            note3 = true
                        end
                    end
                end
            end
        else
            for i = 0, 3, 1 do
                local nTexture = getPropertyFromGroup('opponentStrums', 0, 'texture')
                local x = getPropertyFromGroup('opponentStrums', i, 'x')
                local y = getPropertyFromGroup('opponentStrums', i, 'y')
    
                if nTexture ~= "texture" then
                    setPropertyFromGroup('opponentStrums', i, 'visible', false)
    
                    if not noteCreated then
                        if i == 0 then
                            makeAnimatedLuaSprite("kadeLEFT", nTexture, x, y)
                            luaSpriteAddAnimationByPrefix('kadeLEFT', 'arrowIdle', 'arrowLEFT', 24, true)
                            setObjectCamera('kadeLEFT', 'hud')
                            setProperty('kadeLEFT.alpha', 0)
                            scaleObject('kadeLEFT', 0.7, 0.7)
                            setObjectOrder('kadeLEFT', 10)
                            addLuaSprite("kadeLEFT")
    
                            note0 = true
                        elseif i == 1 then
                            makeAnimatedLuaSprite("kadeDOWN", nTexture, x, y)
                            luaSpriteAddAnimationByPrefix('kadeDOWN', 'arrowIdle', 'arrowDOWN', 24, true)
                            setObjectCamera('kadeDOWN', 'hud')
                            setProperty('kadeDOWN.alpha', 0)
                            scaleObject('kadeDOWN', 0.7, 0.7)
                            setObjectOrder('kadeDOWN', 10)
                            addLuaSprite("kadeDOWN")
    
                            note1 = true
                        elseif i == 2 then
                            makeAnimatedLuaSprite("kadeUP", nTexture, x, y)
                            luaSpriteAddAnimationByPrefix('kadeUP', 'arrowIdle', 'arrowUP', 24, true)
                            setObjectCamera('kadeUP', 'hud')
                            setProperty('kadeUP.alpha', 0)
                            scaleObject('kadeUP', 0.7, 0.7)
                            setObjectOrder('kadeUP', 10)
                            addLuaSprite("kadeUP")
    
                            note2 = true
                        elseif i == 3 then
                            makeAnimatedLuaSprite("kadeRIGHT", nTexture, x, y)
                            luaSpriteAddAnimationByPrefix('kadeRIGHT', 'arrowIdle', 'arrowRIGHT', 24, true)
                            setObjectCamera('kadeRIGHT', 'hud')
                            setProperty('kadeRIGHT.alpha', 0)
                            scaleObject('kadeRIGHT', 0.7, 0.7)
                            setObjectOrder('kadeRIGHT', 10)
                            addLuaSprite("kadeRIGHT")
    
                            note3 = true
                        end
                    end
                end
            end
        end

        if note0 == true and note1 == true and note2 == true and note3 == true then
            noteCreated = true
            lastTexture = getPropertyFromGroup('opponentStrums', 0, 'texture')
        end

        if noteCreated == true then
            local nTexture = getPropertyFromGroup('opponentStrums', 0, 'texture')

            if isPixel then
                nTexture = "pNOTE_assets"
            end

            if luaSpriteExists('kadeLEFT') then
                local mySprite = 'kadeLEFT'
                local noteNum = 0
                setProperty(mySprite .. '.x', getPropertyFromGroup('opponentStrums', noteNum, 'x'))
                setProperty(mySprite .. '.y', getPropertyFromGroup('opponentStrums', noteNum, 'y'))
                setProperty(mySprite .. '.alpha', getPropertyFromGroup('opponentStrums', noteNum, 'alpha'))
                setProperty(mySprite .. '.angle', getPropertyFromGroup('opponentStrums', noteNum, 'angle'))
                --setProperty(mySprite .. '.visible', getPropertyFromGroup('opponentStrums', noteNum, 'visible'))
            end

            if luaSpriteExists('kadeDOWN') then
                local mySprite = 'kadeDOWN'
                local noteNum = 1
                setProperty(mySprite .. '.x', getPropertyFromGroup('opponentStrums', noteNum, 'x'))
                setProperty(mySprite .. '.y', getPropertyFromGroup('opponentStrums', noteNum, 'y'))
                setProperty(mySprite .. '.alpha', getPropertyFromGroup('opponentStrums', noteNum, 'alpha'))
                setProperty(mySprite .. '.angle', getPropertyFromGroup('opponentStrums', noteNum, 'angle'))
            end
    
            if isPixel then
                if luaSpriteExists('kadeUP') then
                    local mySprite = 'kadeUP'
                    local noteNum = 2
                    setProperty(mySprite .. '.x', getPropertyFromGroup('opponentStrums', noteNum, 'x') - 5.5)
                    setProperty(mySprite .. '.y', getPropertyFromGroup('opponentStrums', noteNum, 'y') - 1.5)
                    setProperty(mySprite .. '.alpha', getPropertyFromGroup('opponentStrums', noteNum, 'alpha'))
                    setProperty(mySprite .. '.angle', getPropertyFromGroup('opponentStrums', noteNum, 'angle'))
                end

                if luaSpriteExists('kadeRIGHT') then
                    local mySprite = 'kadeRIGHT'
                    local noteNum = 3
                    setProperty(mySprite .. '.x', getPropertyFromGroup('opponentStrums', noteNum, 'x') - 2.5)
                    setProperty(mySprite .. '.y', getPropertyFromGroup('opponentStrums', noteNum, 'y') - 1.5)
                    setProperty(mySprite .. '.alpha', getPropertyFromGroup('opponentStrums', noteNum, 'alpha'))
                    setProperty(mySprite .. '.angle', getPropertyFromGroup('opponentStrums', noteNum, 'angle'))
                end
            else
                if luaSpriteExists('kadeUP') then
                    local mySprite = 'kadeUP'
                    local noteNum = 2
                    setProperty(mySprite .. '.x', getPropertyFromGroup('opponentStrums', noteNum, 'x'))
                    setProperty(mySprite .. '.y', getPropertyFromGroup('opponentStrums', noteNum, 'y'))
                    setProperty(mySprite .. '.alpha', getPropertyFromGroup('opponentStrums', noteNum, 'alpha'))
                    setProperty(mySprite .. '.angle', getPropertyFromGroup('opponentStrums', noteNum, 'angle'))
                end
                
                if luaSpriteExists('kadeRIGHT') then
                    local mySprite = 'kadeRIGHT'
                    local noteNum = 3
                    setProperty(mySprite .. '.x', getPropertyFromGroup('opponentStrums', noteNum, 'x'))
                    setProperty(mySprite .. '.y', getPropertyFromGroup('opponentStrums', noteNum, 'y'))
                    setProperty(mySprite .. '.alpha', getPropertyFromGroup('opponentStrums', noteNum, 'alpha'))
                    setProperty(mySprite .. '.angle', getPropertyFromGroup('opponentStrums', noteNum, 'angle'))
                end
            end

            if isPixel == false then
                if lastTexture ~= nTexture then
                    removeLuaSprite('kadeLEFT', true)
                    removeLuaSprite('kadeDOWN', true)
                    removeLuaSprite('kadeUP', true)
                    removeLuaSprite('kadeRIGHT', true)
                    
                    lastTexture = nTexture
                    for i = 0, 3, 1 do
                        local x = getPropertyFromGroup('opponentStrums', i, 'x')
                        local y = getPropertyFromGroup('opponentStrums', i, 'y')
            
                        if i == 0 then
                            makeAnimatedLuaSprite("kadeLEFT", nTexture, x, y)
                            luaSpriteAddAnimationByPrefix('kadeLEFT', 'arrowIdle', 'arrowLEFT', 24, true)
                            setObjectCamera('kadeLEFT', 'hud')
                            setProperty('kadeLEFT.alpha', 0)
                            scaleObject('kadeLEFT', 0.7, 0.7)
                            setObjectOrder('kadeLEFT', 10)
                            addLuaSprite("kadeLEFT")
                        elseif i == 1 then
                            makeAnimatedLuaSprite("kadeDOWN", nTexture, x, y)
                            luaSpriteAddAnimationByPrefix('kadeDOWN', 'arrowIdle', 'arrowDOWN', 24, true)
                            setObjectCamera('kadeDOWN', 'hud')
                            setProperty('kadeDOWN.alpha', 0)
                            scaleObject('kadeDOWN', 0.7, 0.7)
                            setObjectOrder('kadeDOWN', 10)
                            addLuaSprite("kadeDOWN")
                        elseif i == 2 then
                            makeAnimatedLuaSprite("kadeUP", nTexture, x, y)
                            luaSpriteAddAnimationByPrefix('kadeUP', 'arrowIdle', 'arrowUP', 24, true)
                            setObjectCamera('kadeUP', 'hud')
                            setProperty('kadeUP.alpha', 0)
                            scaleObject('kadeUP', 0.7, 0.7)
                            setObjectOrder('kadeUP', 10)
                            addLuaSprite("kadeUP")
                        elseif i == 3 then
                            makeAnimatedLuaSprite("kadeRIGHT", nTexture, x, y)
                            luaSpriteAddAnimationByPrefix('kadeRIGHT', 'arrowIdle', 'arrowRIGHT', 24, true)
                            setObjectCamera('kadeRIGHT', 'hud')
                            setProperty('kadeRIGHT.alpha', 0)
                            scaleObject('kadeRIGHT', 0.7, 0.7)
                            setObjectOrder('kadeRIGHT', 10)
                            addLuaSprite("kadeRIGHT")
                        end
                    end
                end
            end
        end
    
        if getProperty("songPercent") > 0 then
            setProperty('black.visible', true)
            setProperty('gray.visible', true)
            setProperty('green.visible', true)
            setProperty('timeTxtKade.visible', true)
        end

        scaleObject('green', 1.965 * getProperty("songPercent"), 0.035)
    
        local fctext = getProperty('ratingFC')
    
        if fctext == "SFC" then
            fctext = "MFC"
        end
    
        local calculatedtype = ""

        if acc == 100 then
            calculatedtype = 'AAAAA'
        elseif acc >= 95 then
            calculatedtype = 'AAAA'
        elseif acc >= 90 then
            calculatedtype = 'AAA'
        elseif acc >= 85 then
            calculatedtype = 'AA'
        elseif acc >= 80 then
            calculatedtype = 'A'
        elseif acc >= 60 then
            calculatedtype = 'B'
        elseif acc >= 40 then
            calculatedtype = 'C'
        elseif acc >= 20 then
            calculatedtype = 'D'
        elseif acc >= 0 then
            calculatedtype = 'F'
        end

        if nps < 0 then
            nps = 0
            noteHitted = false
        end
    
        if botPlay then
            setTextString("scoreTxtKade", "BOTPLAY - NPS: " .. nps .. " | Score:" .. bscore)
        else
            if hits > 0 then
                setTextString("scoreTxtKade", "NPS: " .. nps .. " | Score:" .. score .. " | Combo Breaks:" .. misses .. " | Accuracy:" .. math.floor(acc * 100) / 100 .. "% | (" .. fctext .. ") " .. calculatedtype)
            else
                setTextString("scoreTxtKade", "NPS: 0 | Score:0 | Combo Breaks:0 | Accuracy:0% | N/A")
            end
        end
    end
end

function onUpdatePost()
    if songended == false then
        local songNameNoSpace = songName
        local difficultyNameUpper = string.upper(difficultyName:sub(1, 1)) .. difficultyName:sub(2, #difficultyName)
    
        for i = 1, #songName do
            if songName:sub(i, i) == " " then
                songNameNoSpace = songNameNoSpace:sub(1, i - 1) .. "-" .. songNameNoSpace:sub(i + 1, #songName)
            end
        end

        if botPlay then
            setPropertyFromClass('lime.app.Application', 'current.window.title', "Friday Night Funkin'")
        else
            setPropertyFromClass('lime.app.Application', 'current.window.title', "Friday Night Funkin'")
        end
    end

	for i = 0, getProperty('grpNoteSplashes.length') - 1 do
		setPropertyFromGroup('grpNoteSplashes', i, 'visible', false)
	end
end

function onDestroy()
    songended = true
    setPropertyFromClass('lime.app.Application', 'current.window.title', "Friday Night Funkin': VS Boii and Woofy")
end

function colorFromRating(diff)
    local absDiff = math.abs(diff)

    if absDiff < 46.0 then
        return '00FFFF'
    elseif absDiff < 91.0 then
        return '006400'
    elseif absDiff < 136.0 then
        return 'FFFF00'
    else
        return 'FF0000'
    end
end

function getRatingType(diff)
    local absDiff = math.abs(diff)

    if absDiff < 46.0 then
        return 'SICK'
    elseif absDiff < 91.0 then
        return 'GOOD'
    elseif absDiff < 136.0 then
        return 'BAD'
    else
        return 'SHIT'
    end
end