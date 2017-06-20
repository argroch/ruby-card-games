=begin
	
Rules being followed:
https://www.pagat.com/war/war.html 

=end


require_relative 'deck_maker'
require_relative 'war_methods'




# Build a deck!
deck = deck_maker

# Initialize the hand arrays!
# (go go gadet array hands?) 
@p1_hand, @p2_hand, @war_chest = [], [], []
# Also there's an array to hold cards that are put down as a reults of 'war' being called

# Fill those hand arrays up with cards from the deck
war_deal(deck)

=begin
# Test to make sure both players have 26 cards each:
puts @p1_hand.length
puts "***********"
puts @p2_hand.length
=end


count = 1
# The game continues until someone gets all the cards, so someone is going to end up with an empty deck (array)
until @p1_hand.length == 0 || @p2_hand.length == 0

	# Each player takes the first card from the "top" of their deck (to either return to their deck or their opponents)
	p1_card = @p1_hand.shift
	p2_card = @p2_hand.shift

	# Printing out the match-up of each rounds both serves user experience and testing:
	puts "\n------\n"
	puts "Round #{count}:"
	puts "Player One's card: #{p1_card[0]}#{p1_card[1]}"
	puts "Player Two's card: #{p2_card[0]}#{p2_card[1]}"

	# Set value of face cards to 11-14, or convert string value to integer (see 'war_methods' file for the method def)
	p1_value = value_convert(p1_card[0])
	p2_value = value_convert(p2_card[0])

	# Make sure value conversion has worked:
	# puts "Player 1 Value: #{p1_value}"
	# puts "*******"
	# puts "Player 2 Value: #{p2_value}"

	# Now time to compare!
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
	# print @p1_hand
	puts ""
	puts "One: #{@p1_hand.length}"
	# print @p2_hand
	puts ""
	puts "Two: #{@p2_hand.length}"
	puts ""
	puts "-------"

	# We need to shuffle the hands every now and then or this thing is just gonna go on forever.
	# Shuffling every 26 (initial # of cards in a hand) would seem the most logical, but we would still most often end up with over 1000 rounds each game, so I'm halving that number and shuffling every 13 rounds.
	if count % 13 == 0 && ( @p1_hand.length != 0 && @p2_hand.length != 0 )
		puts "*******\nShuffling...\n*******"  

		@p1_hand.shuffle!
		@p2_hand.shuffle!
	end	
end


if @p1_hand.length == 0
	puts "\n Player Two wins!"
else
	puts "\n Player One wins!"
end
