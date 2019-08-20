require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test
  def setup
    @cell_1 = Cell.new("B4")
  end

  def test_it_exists
    assert_instance_of Cell, @cell_1
  end

  def test_coordinate
    assert_equal "B4", @cell_1.coordinate
  end

  def test_if_cell_starts_with_nil_ship
    assert_nil @cell_1.ship
  end

  def test_if_empty?
    # cruiser = Ship.new("Cruiser", 3)
    assert_equal true, @cell_1.empty?
  end

  def test_if_ship_is_placed
    cruiser = Ship.new("Cruiser", 3)
    @cell_1.place_ship(cruiser)
    assert_instance_of Ship, @cell_1.ship
    assert_equal false, @cell_1.empty?
  end

  def test_if_fired_upon
    cruiser = Ship.new("Cruiser", 3)
    @cell_1.place_ship(cruiser)
    assert_equal false, @cell_1.fired_upon?
  end

  def test_if_firing_hits_anything
    cruiser = Ship.new("Cruiser", 3)
    @cell_1.place_ship(cruiser)
    @cell_1.fired_upon

    assert_equal 2, cruiser.health
    assert_equal true, @cell_1.fired_upon?
  end
end
