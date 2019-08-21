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

  def test_cell_keys_generation
    # right now, just testing for a 4x4 board
    @board.size(4,4)
    #require 'pry'; binding.pry
    keys = [
      "A1", "A2", "A3", "A4",
      "B1", "B2", "B3", "B4",
      "C1", "C2", "C3", "C4",
      "D1", "D2", "D3", "D4"
    ]
    # assert_equal keys, @board.size(4,4)
    assert_equal 16, @board.size(4,4).length
    # assert_equal keys, @board.cells.keys

  end
end
