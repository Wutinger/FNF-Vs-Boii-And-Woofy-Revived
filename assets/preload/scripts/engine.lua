function onCreatePost()
    local songNameNoSpace = songName
    local difficultyNameUpper = string.upper(difficultyName:sub(1, 1)) .. difficultyName:sub(2, #difficultyName)
    
    makeLuaText("infoTxtKade", songNameNoSpace .. " " .. difficultyNameUpper .. " - Boii Engine", 0, 30, 660)
    setTextSize('infoTxtKade', 16)
    setTextAlignment('infoTxtKade', 'LEFT')
    setObjectOrder('infoTxtKade', 40)
    setTextSize("scoreTxt", 17) --the last number controlls the size of the hud
    setProperty('scoreTxt.y', 690)
    --changeNoteSkin('2d', 'player')
	changeNoteSkin('3d', 'opponent')
end

function changeNoteSkin(skin, player)
    if not (skin == 'vanilla') then -- checks if skin isn't vanilla (basic one)
	local mustHit = true -- mustHit detects bf's notes
	if player == 'opponent' then
		mustHit = false -- if it's false then it's opponent's notes
	end

	for i = 0, getProperty(player..'Strums.length')-1 do -- strums from the player parameter (ONLY OPPONENT AND PLAYER)
            setPropertyFromGroup(player..'Strums', i, 'texture', 'noteskins/'..skin) -- changes the noteskin from parameter skin
        end

        for i = 0, getProperty('unspawnNotes.length')-1 do -- counts all unspawned notes
            if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' then -- checks if the note is normal note
		if mustHit and getPropertyFromGroup('unspawnNotes', i, 'mustPress') then -- does a check if it's a player note
                	setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteskins/'..skin) -- sets player's noteskin
		elseif not mustHit and not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then -- opponent note check
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteskins/'..skin) -- sets the opponent note
		end
            end
        end
    end
end