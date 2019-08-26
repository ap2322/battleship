require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
# require '../runner_file'
require './lib/computer'
require './lib/player'

class PlayerTest < Minitest::Test

  def setup
    @player = Player.new
    @board_comp = Board.new
    @board_user = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @all_ships = [@cruiser, @submarine]

  end

  def test_player_exists

    assert_instance_of Player, @player
  end

  def test_string_to_array
    input_string = "A1 A2 A3"

    assert_equal ["A1", "A2", "A3"], @player.string_placement_to_array(input_string)
  end

  def test_take_shot
    @board_comp.place(@cruiser, ["A1", "A2", "A3"])
    @player.take_shot("A1", @board_comp)

    assert_equal true, @board_comp.cells["A1"].fired_upon?
    assert_equal false, @board_comp.cells["B1"].fired_upon?
  end


end
