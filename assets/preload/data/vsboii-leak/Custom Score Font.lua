function onCreatePost()
	makeLuaText("scoretext", "skill issue", 1000, 140, 670)
	setTextAlignment("scoretext", 'center')
	setTextSize("scoretext", 20)
	setTextFont("scoretext", "psych.ttf");
	setTextFont("timeTxt", "psych.ttf");
	addLuaText("scoretext")
	setProperty("infoTxtKade.y", -500)
	--for i=0,3 do
    --    setPropertyFromGroup('opponentStrums', i, 'texture', '2d')
	--	setPropertyFromGroup('playerStrums', i, 'texture', '2d')
    --end
	changeNoteSkin('2d', 'player')
	changeNoteSkin('2d', 'opponent')
end
function onUpdatePost()
	setProperty("scoreTxt.y", -100)
	setTextString("scoretext", 'Score: '..score..' | Misses: '..misses..' | Rating: '..ratingName)
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