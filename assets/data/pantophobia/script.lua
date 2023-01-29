function opponentNoteHit()
       health = getProperty('health')
    if getProperty('health') > 0.05 then
       setProperty('health', health- 0.001);
	end
end

function onCreatePost()
   makeLuaText("message", "Song by xJonny | bro turned into bob and bambi at the same time", 500, 30, 50)
   setTextAlignment("message", "left")
   addLuaText("message")

   makeLuaText("engineText", "Pantophobia - Vs Boii V5(?)", 500, 30, 30)
   setTextAlignment("engineText", "left")
   addLuaText("engineText")
   setProperty('message.y', 680)
   setProperty('engineText.y', 660)
end