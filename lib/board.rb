class Board
  attr_reader :cells

  def initialize
    @cells = Hash.new()
    @cells["A1"] = Cell.new("A1")
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
