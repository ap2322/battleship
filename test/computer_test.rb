require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'
require './lib/player'
require 'pry'

class ComputerTest < Minitest::Test

  def setup
    @comp1 = Computer.new
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @player = Player.new
  end

  def test_it_exists
    assert_instance_of Computer, @comp1
  end

  def test_random_placements
    all_placements_for_cruiser = @comp1.all_possible_placements(@board, @cruiser)
    all_placements_for_sub = @comp1.all_possible_placements(@board, @submarine)

    assert_equal @cruiser.length, all_placements_for_cruiser.first.length
    assert_equal @submarine.length, all_placements_for_sub.first.length

  end

  def test_place_cruiser
    @comp1.place_on_board(@cruiser, @board)
    cell_with_ship_on_board = @board.cells.values.find {|cell| cell.ship == @cruiser}

    assert_equal false, cell_with_ship_on_board.empty?
  end

  def test_not_placed
    # ship is not placed on board with zero sample placements
    cell_with_ship_on_board = nil
    cell_with_ship_on_board = @board.cells.values.find {|cell| cell.ship == @cruiser}

    assert_nil cell_with_ship_on_board
  end

  def test_all_possible_placements
     expected = [ ["A1", "A2", "A3"],
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

  def test_smart_shot
    @comp1.take_shot(@board)
    @comp1.take_shot(@board)

    assert_equal ["M", "M"], @comp1.shots_rendered(@board)

  end

end
