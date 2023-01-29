function opponentNoteHit()
	health = getProperty('health')
	if health > 0.02 then
		setProperty('health', health - 0.02);	
	end
end

function onCreatePost()
   makeLuaText("message", "Song by KawaiiSprite (fnf week 7)", 500, 30, 50)
   setTextAlignment("message", "left")
   addLuaText("message")

   makeLuaText("engineText", "Bones (stress cover) - Vs Boii and Woofy V5", 500, 30, 30)
   setTextAlignment("engineText", "left")
   --addLuaText("engineText")
   setProperty('message.y', 680)
   --setProperty('engineText.y', 660)
end