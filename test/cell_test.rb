require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test
  def setup
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")
    @ship = Ship.new("Cruiser", 3)
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

    assert_equal true, @cell_1.empty?

    @cell_2.place_ship(@ship)

    assert_equal false, @cell_2.empty?
  end

  def test_if_ship_is_placed
    @cell_1.place_ship(@ship)

    assert_instance_of Ship, @cell_1.ship
    assert_equal false, @cell_1.empty?
  end

  def test_if_fired_upon
    @cell_1.place_ship(@ship)

    assert_equal false, @cell_1.fired_upon?
  end

  def test_if_firing_hits_anything
    @cell_1.place_ship(@ship)
    @cell_1.fire_upon

    assert_equal 2, @ship.health
    assert_equal true, @cell_1.fired_upon?
  end

  def test_render_period
    assert_equal ".", @cell_1.render
  end

  def test_render_m
    @cell_1.fire_upon

    assert_equal "M", @cell_1.render
  end

  def test_render_s
    @cell_2.place_ship(@ship)

    assert_equal ".", @cell_2.render
    assert_equal "S", @cell_2.render(true)
  end

  def test_render_h
    @cell_2.place_ship(@ship)
    @cell_2.fire_upon

    assert_equal "H", @cell_2.render
  end

  def test_render_x
    @cell_2.place_ship(@ship)
    @cell_2.fire_upon
    @ship.hit
    @ship.hit

    assert_equal "X", @cell_2.render
  end
end
