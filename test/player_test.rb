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
  end

  def test_player_exists

    assert_instance_of Player, @player
  end

  def test_string_to_array
    input_string = "A1 A2 A3"

    assert_equal ["A1", "A2", "A3"], @player.string_placement_to_array(input_string) 

  end


end
