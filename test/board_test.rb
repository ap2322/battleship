require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_cells_is_hash_of_Cells
    assert_instance_of Hash, @board.cells
    assert_instance_of Cell, @board.cells.values[0]
  end


  def test_make_cells
    keys = [
      "A1", "A2", "A3", "A4",
      "B1", "B2", "B3", "B4",
      "C1", "C2", "C3", "C4",
      "D1", "D2", "D3", "D4"
    ]
    assert_equal keys, @board.cells.keys
  end


  def test_valid_placement_length
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, @board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end

  def test_same_letter_make_array_of_numbers
    assert_equal [1, 2, 3], @board.numbers_in_placement_same_letter(["A1", "A2", "A3"])
  end

  def test_possible_placements_same_letter
    range = (1..4)
    length = 3
    length_2 = 2
    expected = [[1, 2], [2, 3], [3, 4]]
    assert_equal [[1, 2, 3], [2, 3, 4]], @board.num_coordinates_possible(range, length)
    assert_equal expected, @board.num_coordinates_possible(range, length_2)


  end

end
