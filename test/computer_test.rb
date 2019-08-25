require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/runner_file'
require './lib/computer'
require 'pry'

class ComputerTest < Minitest::Test

  def setup
    @comp1 = Computer.new
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Computer, @comp1
  end

  # def test_place_cruiser
  #   random_placement = @board.cells.keys.each_cons(@cruiser.length)
  #   binding.pry
  #   assert_equal random_placement, @comp1.generate_placement
  # end

  def test_invalid_until_valid_placement
    # ship is not placed on board with zero sample placements
    # ship is still not placed on board with an invalid placement
    # ship is placed on board with valid placement

  end

  def test_all_possible_placements
     expected = [["A1", "A2", "A3"],
["A2", "A3", "A4"],
["A3", "A4", "B1"],
["A4", "B1", "B2"],
["B1", "B2", "B3"],
["B2", "B3", "B4"],
["B3", "B4", "C1"],
["B4", "C1", "C2"],
["C1", "C2", "C3"],
["C2", "C3", "C4"],
["C3", "C4", "D1"],
["C4", "D1", "D2"],
["D1", "D2", "D3"],
["D2", "D3", "D4"]]

assert_equal expected, @comp1.all_possible_placements(@board, @cruiser)

  end



end
