require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'
require './lib/player'
require 'pry'

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

  def test_string_to_array_ruby_methods
    # not a real test, but confirming output of string.upcase.split(" ")
    input_string = "A1 A2 A3"
    input2 = "b1 c1"

    assert_equal ["A1", "A2", "A3"], input_string.upcase.split(" ")
    assert_equal ["B1", "C1"], input2.upcase.split(" ")
  end

  def test_shot_on_board
    assert_equal false, @player.shot_on_board("A5", @board_comp)
    assert_equal true, @player.shot_on_board("B1", @board_comp)
  end

  def test_if_shots_taken
    @player.take_shot (@board_comp) #input "A1"

    assert_equal false, @player.shot_already_taken?("A2")
    assert_equal true, @player.shot_already_taken?("A1")
  end


end
