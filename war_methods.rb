def war_deal(deck)
	# Build a hand for each player out of the deck 26 times (deck.length by half); twice pull a random card from the deck and put into a player's hand, while deleting it from the original deck (so we never get the same sample-ing) 
	(deck.length/2).times do 
		@p1_hand.push(deck.delete(deck.sample))
		@p2_hand.push(deck.delete(deck.sample))
	end
end

# Set value of face cards to 11-14, or convert string value to integer
def value_convert(str)
	int_value = 0
	case str
		when "J" then int_value = 11
		when "Q" then int_value = 12
		when "K" then int_value = 13
		when "A" then int_value = 14
		else int_value = str.to_i
	end
	return int_value
end

def value_compare(val1,val2)
	if val1 == val2
		# It's a tie! that means: IT'S WAR!
		war_time
	elsif val1 > val2
		# Player 1 has won this round, the method returns the Integer 0 to decide a conditional statement after the method has been called
		return 0
	else
		# Player 2 has won this round, the method returns the Integer 1 to decide a conditional statement after the method has been called
		return 1
	end
end

def war_time
	# Each player puts down two additional cards:
	#  * one facing down, one facing up
	#  * whoever has the highest value card wins all the cards

	# What if a player does not have enough cards to go through with war? That player will be forced to forfeit.

	# Check to see if one of the players has only one or zero cards at this point:
	if @p1_hand.length < 2
		# Player 1 doesn't have enough cards to war. The rest of their cards are added to Player 2's hand and cleared from their own.
		@p2_hand += @p1_hand
		@p1_hand.clear
	elsif @p2_hand.length < 2
		# Player 2 doesn't have enough cards to war. The rest of their cards are added to Player 1's hand and cleared from their own.
		@p1_hand += @p2_hand
		@p2_hand.clear
	else
		# Okay, both have enough cards, let's do some warring.
		# First we'll add the down-facing cards to the "war chest"
		@war_chest += [@p1_hand.shift, @p2_hand.shift]

		# Then we'll have the up-facing cards, we need those in their own variable to print out and pass along the value
		p1_up_card = @p1_hand.shift
		p2_up_card = @p2_hand.shift
		# These cards will also be added to the "war chest"
		@war_chest += [p1_up_card, p2_up_card]

		puts "IT'S WAR!"
		puts "Player One's card: #{p1_up_card[0]}#{p1_up_card[1]}"
		puts "Player Two's card: #{p2_up_card[0]}#{p2_up_card[1]}"
		puts ""

		# Have to convert before we compare:
		p1_value = value_convert(p1_up_card[0])
		p2_value = value_convert(p2_up_card[0])

		# Let's compare again
		value_compare(p1_value, p2_value)
	end
end