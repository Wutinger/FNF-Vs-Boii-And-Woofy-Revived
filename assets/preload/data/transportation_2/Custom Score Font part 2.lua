function onUpdatePost()
	local BeforeScore = 'Score: '..score..' | Misses: '..misses..' | Rating: '..ratingName
    local FinalScore = 'Score: '..score..' | Misses: '..misses..' | Rating: '..ratingName..' ('..rateFullPer..'%) - '..ratingFC

    if ratingName == '?' then
        setTextString('scoreTxt', BeforeScore)
    else
        setTextString('scoreTxt', FinalScore)  
    end
end