class Board
  attr_reader :cells

  def initialize
    @cells = make_board
  end

  def make_board
    cells_hash = Hash.new
    keys = [
      "A1", "A2", "A3", "A4",
      "B1", "B2", "B3", "B4",
      "C1", "C2", "C3", "C4",
      "D1", "D2", "D3", "D4",
    ]
    keys.each do |key|
      cells_hash[key] = Cell.new(key)
    end
    cells_hash
  end

#If letters are all equal and numbers must be consecutive
  def same_letter_coords?(coordinates)
    letters = coordinates.map do |coord|
      coord[0]
    end
    letters.uniq.length == 1
  end

  def horizontal(coordinates)
    coordinates.map do |coord|
      coord[1].to_i
    end
  end

  def num_coordinates_possible(range, length)
    valid_segment = []
    range.each_cons(length) do |segment|
      valid_segment << segment
    end
    valid_segment
  end

  def horizontal_ok?(coordinates, range = (1..4), length)
    num_coordinates_possible(range , length).include?(
    horizontal(coordinates))
  end

  # If numbers are all equal and letters must be consecutive
  def same_number_coords?(coordinates)
    numbers = coordinates.map do |coord|
      coord[1]
    end
    numbers.uniq.length == 1
  end

  def vertical(coordinates)
    coordinates.map do |coord|
      coord[0].ord
    end
  end

  def vertical_ok?(coordinates, range = (65..68), length)
    letter_coordinates_possible(range , length).include?(
    vertical(coordinates))
  end

  def letter_coordinates_possible(range, length)
    valid_segment = []
    range.each_cons(length) do |segment|
      valid_segment << segment
    end
    valid_segment
  end

  def valid_placement?(ship, coordinates)
    return false if ship.length != coordinates.length
    return false if overlap?(coordinates)

    valid = false

    if same_letter_coords?(coordinates) &&
       horizontal_ok?(coordinates, ship.length)
      valid = true
    elsif same_number_coords?(coordinates) &&
          vertical_ok?(coordinates, ship.length)
      valid = true
    end

    valid
  end



  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coord|
        cells[coord].place_ship(ship)
      end
    end
  end

  def overlap?(coordinates)
    # look through cells that are not empty and make array
    not_empty_on_board = []
    cells.values.each do |cell|
      if cell.empty? == false
        not_empty_on_board << cell.coordinate
      end
    end

    not_empty_on_board.flatten!
    # loop through possible coordinates for placement
    # make an array of [true, false] if they are included in the not_empty_on_board
    on_board = coordinates.map do |coord|
      not_empty_on_board.include?(coord)
    end
    # return true if your on_board array includes true
    on_board.include?(true)
  end

  def top_row_render
    board_string = " "
    range = cells.keys.map {|coord| coord[1]}
    range.uniq!
    range.each do |num|
      board_string << " #{num}"
    end
    board_string << " "
  end

  def render(show = false)
    board_string = top_row_render

    cells.each_with_index do |(coord, cell), index|
      if cells.keys[index][0] != cells.keys[index-1][0]
          board_string << "\n#{coord[0]} "
          # binding.pry
      end
      board_string << cell.render(show) + " "
    end

    board_string << "\n"
  end

end
