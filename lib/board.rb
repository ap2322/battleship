class Board
  attr_reader :cells

  def initialize
    @cells = Hash.new
    keys = [
      "A1", "A2", "A3", "A4",
      "B1", "B2", "B3", "B4",
      "C1", "C2", "C3", "C4",
      "D1", "D2", "D3", "D4",
    ]
    keys.each do |key|
      @cells[key] = Cell.new([key])
    end
  end

#If letters are all equal and numbers must be consecutive
  def same_letter_coords?(coordinates)
    letters = coordinates.map do |coord|
      coord[0]
    end
    letters.uniq.length == 1
  end

  def numbers_in_placement_same_letter(coordinates)
    placement_nums = coordinates.map do |coord|
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

  def same_letter_num_ok?(coordinates, range = (1..4), length)
    num_coordinates_possible(range , length).include?(
    numbers_in_placement_same_letter(coordinates))
  end

  # If numbers are all equal and letters must be consecutive
  def same_number_coords?(coordinates)
    numbers = coordinates.map do |coord|
      coord[1]
    end
    numbers.uniq.length == 1
  end

  def letters_in_placement_same_number(coordinates)
    placement_letters = coordinates.map do |coord|
      coord[0].ord
    end
  end

  def same_num_letters_ok?(coordinates, range = (65..68), length)
    letter_coordinates_possible(range , length).include?(
    letters_in_placement_same_number(coordinates))
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
       same_letter_num_ok?(coordinates, ship.length)
      valid = true
    elsif same_number_coords?(coordinates) &&
          same_num_letters_ok?(coordinates, ship.length)
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
    # TODO use a union | or intersection & method to compare arrays
    on_board = coordinates.map do |coord|
      not_empty_on_board.include?(coord)
    end
    # return true if your on_board array includes true
    on_board.include?(true)
  end

  def render(show=false)
    # map cells.values.render to an array
    cell_render_array = @cells.values.map {|cell| cell.render(true)}
    key_letter_array = @cells.keys.map {|key| key[0].ord }
    top_numbers_array = @cells.keys.map {|key| key[1]}
    top_numbers_array.uniq!
    str_of_rows = " "

    top_numbers_array.each { |num| str_of_rows += "#{num} "}


    key_letter_array.each_with_index do |key, index|
      if key_letter_array[index-1] != key_letter_array[index]
        str_of_rows.concat("\n #{key.chr} ")
      end
      str_of_rows += cell_render_array[index] + " "
      # binding.pry

    end

    str_of_rows



    # board_string1 = " "
    # board_stringA = ""
    # # make an array of just A cell.renders
    # @cells.each do |key, value|
    #   if key[0] == "A"
    #     board_stringA << value.render(true)
    #   end
    # end

    # @cells.each_cons(2) do |k1, k2|
    #   if k2[0].ord > k1[0].ord
    #     board_string1.concat("\n")
    #   end
    # end
    # @cells.each do |coord, cell|
    #   board_string.concat(cell.render(show))
    # end
    # board_stringA
  end


end


# Think about this when refactoring for variable board size
  # def size(y, x)
  #   keys = []
  #   y.times do |y|
  #     # keys << y
  #     x.times do |x|
  #       keys << x
  #     end
  #   end
  #   keys
  # end
