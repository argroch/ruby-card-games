def deck_maker
	@numbers = %w(2 3 4 5 6 7 8 9 10 J Q K A)

	@suits = %w(♦ ♠ ♥ ♣)

	deck, card = [], []

	@numbers.each do |num|
		@suits.map { |s| deck.push([num, s]) }
	end

	# print deck
	# puts ""
	return deck
end