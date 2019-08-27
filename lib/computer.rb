class Computer
  attr_reader :shots_taken

  def initialize
    @shots_taken = []
  end

# Place a Ship and a Cruiser in random places on the board
# These placements must be valid.
  def all_possible_placements(board, ship)
    all_random_placements = []
    board.cells.keys.each_cons(ship.length) do |key|
      all_random_placements << key
    end
    all_random_placements
  end


  def place_on_board(ship, board)
    generated_placement = all_possible_placements(board, ship).sample
    until board.valid_placement?(ship, generated_placement) do
      generated_placement = all_possible_placements(board, ship).sample
    end
    board.place(ship, generated_placement)
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

  def make_smart_hits_available(board, hit_coord = @shots_taken.last)
    l = hit_coord[0]
    num = hit_coord[1].to_i

    sh_1 = l + num.next.to_s
    sh_2 = l + num.pred.to_s
    sh_3 = l.next + num.to_s
    sh_4 = l.ord.pred.chr + num.to_s

    smart_hits = [sh_1, sh_2, sh_3, sh_4]
    smart_hits & board.cells.keys
  end

  def make_smart_shot(board)
    smart_shot = make_smart_hits_available(board).sample
    while @shots_taken.include?(smart_shot)
      smart_shot = make_smart_hits_available(board).sample
    end
    @shots_taken << smart_shot
    smart_shot

  end

  def take_smart_shot(board)
    # hit_coord #starting coordinate
    # make_smart_hits_available(board, hit_coord)
    board.cells[make_smart_shot(board)].fire_upon
  end

end
