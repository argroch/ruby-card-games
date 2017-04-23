# set value of face cards to 11-14,
# or convert string value to integer
def value_convert(str)
	int_value = 0
	case str
		when "J" then int_value = 11
		when "Q" then int_value = 12
		when "K" then int_value = 13
		when "A" then int_value = 14
		else
			value = str.to_i
	end
	return int_value
end

def value_compare(card1,card2,hand1,hand2)
	if card1[0] == card2[0]
		# it's a tie! that means: IT'S WAR!
		# each player puts down three additional cards:
		# two facing down, one facing up
		# whoever has the highest value card wins all the cards
		war_chest = [hand1.shift, hand1.shift, hand2.shift, hand2.shift]
		p1_war_card = hand1.shift
		p2_war_card = hand2.shift

		puts "IT'S WAR!"
		puts "Player One's card: #{p1_war_card[0]}#{p1_war_card[1]}"
		puts "Player Two's card: #{p2_war_card[0]}#{p2_war_card[1]}"
		puts ""
		# we call the method again to compare the third card
		value_compare(p1_war_card[0], p2_war_card[0], hand1, hand2)
	elsif card1[0] > card2[0]
		# player 1 takes the two cards, puts them in the bottom of their hand
		hand1 += [card1, card2]
	else
		# player 2 takes the two cards, puts them in the bottom of their hand
		hand2 += [card1, card2]
	end
end
