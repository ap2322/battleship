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
    assert_instance_of Cell, @board.cells.values.class
  end

  def test_cell_keys_generation
    # right now, just testing for a 4x4 board
    @board.size(4,4)

  end
end
