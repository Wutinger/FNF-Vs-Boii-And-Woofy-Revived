function onCreatePost()
   makeLuaText("message", "Whar?", 500, 30, 50)
   setTextAlignment("message", "left")
   addLuaText("message")

   makeLuaText("engineText", "Wut - Vs Boii and Woofy V5", 500, 30, 30)
   setTextAlignment("engineText", "left")
   addLuaText("engineText")
   setProperty('message.y', 680)
   setProperty('engineText.y', 660)
end