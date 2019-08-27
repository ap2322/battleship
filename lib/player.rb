class Player
  attr_reader :shots_taken

  def initialize
    @shots_taken = []
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

  def shot_on_board(shot, board)
    if !board.cells.keys.include?(shot)
      puts "Please enter a valid coordinate:"
      return false
    end
    true
  end

  def shot_already_taken?(shot)
    if @shots_taken.include?(shot)
      puts "You've already fired there. Please pick a different coordinate: "
      return true
    end
    false
  end

  def take_shot(board)
    shot = gets.chomp #moved from runner into method
    until shot_on_board(shot, board) && !shot_already_taken?(shot) do
      print ">"
      shot = gets.chomp
    end
    @shots_taken << shot
    board.cells[shot].fire_upon
    # binding.pry
  end



end
