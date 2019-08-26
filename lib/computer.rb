class Computer
  attr_reader :shots_taken

  def initialize
    @shots_taken = []
  end

# Place a Ship and a Cruiser in random places on the board
# These placements must be valid.
  def all_possible_placements(board, ship)
    random_placement = []
    board.cells.keys.each_cons(ship.length) do |key|
      random_placement << key
    end
    random_placement
  end


  def place_on_board(ship, board)
    placed = false
    generated_placement = all_possible_placements(board, ship).sample
    until board.valid_placement?(ship, generated_placement) do
      generated_placement = all_possible_placements(board, ship).sample
    end
    placed = true
    board.place(ship, generated_placement)
    placed = true
  end

  def place_all_ships(board, ships)
    ships.each do |ship|
      place_on_board(ship, board)
    end
    "I have laid out my ships on the grid."
  end

  def generate_shot(board)
    comp_shot = board.cells.keys.sample
    while @shots_taken.include?(comp_shot)
      comp_shot = board.cells.keys.sample
    end
    @shots_taken << comp_shot
    comp_shot
  end

  def take_shot(board)
    board.cells[generate_shot(board)].fire_upon
  end

end
