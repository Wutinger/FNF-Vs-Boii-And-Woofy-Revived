function onCreatePost()
    local songNameNoSpace = songName
    local difficultyNameUpper = string.upper(difficultyName:sub(1, 1)) .. difficultyName:sub(2, #difficultyName)
    
    makeLuaText("infoTxtKade", songNameNoSpace .. " " .. difficultyNameUpper .. " - Boii Engine BETA", 0, 30, 660)
    setTextSize('infoTxtKade', 16)
    setTextAlignment('infoTxtKade', 'LEFT')
    setObjectOrder('infoTxtKade', 40)

end