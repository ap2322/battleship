class Player

  def initialize

  end

  def string_placement_to_array(placement_string)
    placement = placement_string.split(" ")
  end

  def place_on_board(ship, board, placement)
    placed = false
    # generated_placement = all_possible_placements(board, ship).sample
    until board.valid_placement?(ship, placement) do
      puts "That is not a valid placement! Try again."
      print ">"
      placement_string = gets.chomp
      placement = string_placement_to_array(placement_string)
    end
    placed = true
    board.place(ship, placement)
    placed = true
    puts "You've placed your ship. Good luck."

  end

  def place_all_ships(board, ships)
    ships.each do |ship|
      place_on_board(ship, board)
    end
  end



end
