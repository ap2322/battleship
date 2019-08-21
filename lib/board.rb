class Board
  # attr_reader :cells

  def initialize
    @cells = Hash.new
  end

  def cells
    keys = [
      "A1", "A2", "A3", "A4",
      "B1", "B2", "B3", "B4",
      "C1", "C2", "C3", "C4",
      "D1", "D2", "D3", "D4",
    ]
    keys.each do |key|
      @cells[key] = Cell.new([key])
    end
    @cells
  end

#If letters are all equal and numbers must be consecutive
  def same_letter_coords?(coordinates)
    letters = coordinates.map do |coord|
      coord[0]
    end
    letters.uniq.length == 1
  end
# If numbers are all equal and letters must be consecutive
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
    self.num_coordinates_possible(range , length).include?(
    self.numbers_in_placement_same_letter(coordinates))
  end



  # if same letter, are numbers_in_placement_same_letter in num_coordinates_possible?

  def valid_placement?(ship, coordinates)
    valid = false
    if ship.length == coordinates.length
      if self.same_letter_coords?(coordinates) && self.same_letter_num_ok?(coordinates, ship.length)
        valid = true
      # elsif same_number_coords? && same_number_letters_ok?
        #valid = true
      end
    end
    valid
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
