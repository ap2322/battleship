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

  def valid_coordinate?(coordinate)
    self.cells.values
    cell_coordinate_array = self.cells.values.map do |cell|
      cell.coordinate
    end
    cell_coordinate_array.flatten.include?(coordinate)
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
