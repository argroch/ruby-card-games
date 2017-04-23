require_relative 'deck_maker'
# require_relative 'war_methods'

def war_deal(deck)
	# build a hand for each player out of the deck
	# 26 times (deck.length by half), twice pull a random card from the deck and put into a player's hand, while deleting it from the original deck (so we never get the same sample-ing) 
	(deck.length/2).times do 
		@p1_hand.push(deck.delete(deck.sample))
		@p2_hand.push(deck.delete(deck.sample))
	end
end

# set value of face cards to 11-14,
# or convert string value to integer
def value_convert(str)
	puts str
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
		# it's a tie! that means: IT'S WAR!
		war_time
	elsif val1 > val2
		# player 1 has won this round, the method returns the Integer 0 to decide a conditional statement after the method has been called
		return 0
	else
		# player 2 has won this round, the method returns the Integer 1 to decide a conditional statement after the method has been called
		return 1
	end
end

def war_time
	# each player puts down three additional cards:
	# two facing down, one facing up
	# whoever has the highest value card wins all the cards
	
	# first we'll add the down-facing cards to the "war chest"
	@war_chest += [@p1_hand.shift, @p1_hand.shift, @p2_hand.shift, @p2_hand.shift]

	# then we'll have the up-facing cards, we need those in their own variable to print out and pass along the value
	p1_up_card = @p1_hand.shift
	p2_up_card = @p2_hand.shift
	# these cards will also be added to the "war chest"
	@war_chest += [p1_up_card, p2_up_card]

	puts "IT'S WAR!"
	puts "Player One's card: #{p1_up_card[0]}#{p1_up_card[1]}"
	puts "Player Two's card: #{p2_up_card[0]}#{p2_up_card[1]}"
	puts ""

	# have to convert before we compare:
	p1_value = value_convert(p1_up_card[0])
	p2_value = value_convert(p2_up_card[0])

	# let's compare again
	value_compare(p1_value, p2_value)
end


# build a deck!
deck = deck_maker

# initialize the hand arrays!
# (go go gadet array hands?) 
@p1_hand, @p2_hand, @war_chest = [], [], []
# also there's an array to hold cards that are put down as a reults of 'war' being called

# fill those hand arrays up with cards from the deck
war_deal(deck)

count = 1
# the game continues until someone gets all the cards, so someone is going to end up with an empty deck (array)
until @p1_hand.length == 0 || @p2_hand.length == 0

	# each player takes the first card from the "top" deck (to either return to their deck or their opponents)
	p1_card = @p1_hand.shift
	p2_card = @p2_hand.shift

	puts ""
	puts "------"
	puts ""
	puts "Round #{count}:"
	puts "Player One's card: #{p1_card[0]}#{p1_card[1]}"
	puts "Player Two's card: #{p2_card[0]}#{p2_card[1]}"

	# set value of face cards to 11-14, or convert string value to integer (see 'war_methods' file for the method def)
	p1_value = value_convert(p1_card[0])
	p2_value = value_convert(p2_card[0])

	# now time to compare!
	result = value_compare(p1_value, p2_value)

	case result 
		when 0 # player one wins
			@p1_hand += [p1_card,p2_card]
			@p1_hand += @war_chest if !@war_chest.empty?
			@war_chest.clear
		when 1 # player two wins
			@p2_hand += [p1_card,p2_card]
			@p2_hand += @war_chest if !@war_chest.empty? 
			@war_chest.clear
	end

	count += 1
	puts ""
	puts "Deck sizes:"
	print @p1_hand
	puts ""
	puts "One: #{@p1_hand.length}"
	print @p2_hand
	puts ""
	puts "Two: #{@p2_hand.length}"
	puts ""
	puts "-------"
end


# if p1_hand.length == 0
# 	puts "\n Player Two wins!"
# else
# 	puts "\n Player One wins!"
# end