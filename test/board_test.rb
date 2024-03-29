require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_cells_is_hash_of_Cells

    assert_instance_of Hash, @board.cells
    assert_instance_of Cell, @board.cells.values[0]
  end

  def test_make_board
    keys = [
      "A1", "A2", "A3", "A4",
      "B1", "B2", "B3", "B4",
      "C1", "C2", "C3", "C4",
      "D1", "D2", "D3", "D4"
    ]

    assert_equal keys, @board.cells.keys

    # board2 = Board.new(5, 5)
    # keys2 = [
    #   "A1", "A2", "A3", "A4", "A5",
    #   "B1", "B2", "B3", "B4", "B5",
    #   "C1", "C2", "C3", "C4", "C5",
    #   "D1", "D2", "D3", "D4", "D5",
    #   "E1", "E2", "E3", "E4", "E5"
    # ]
    #
    # assert_equal keys2, board2.cells.keys
  end

  def test_valid_placement_length

    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
  end

  def test_same_letter_make_array_of_numbers
    assert_equal [1, 2, 3], @board.horizontal(["A1", "A2", "A3"])
  end

  def test_possible_placements_same_letter
    range = (1..4)
    length = 3
    length_2 = 2
    expected = [[1, 2], [2, 3], [3, 4]]

    assert_equal [[1, 2, 3], [2, 3, 4]], @board.num_coordinates_possible(range, length)
    assert_equal expected, @board.num_coordinates_possible(range, length_2)


  end

  def test_chosen_coord_numbers_are_in_possilbe_coordinates
    range = (1..4)
    length = 3
    chosen_coords = ["A2", "A3", "A4"]

    assert_equal true, @board.horizontal_ok?(chosen_coords, range, length)
  end

  def test_same_letter_coords
    chosen_coords = ["A2", "A3", "A4"]
    chosen_coords2 = ["A1", "B1", "C1"]

    assert_equal true, @board.same_letter_coords?(chosen_coords)
    assert_equal false, @board.same_letter_coords?(chosen_coords2)
  end

  def test_valid_placement_same_letter_helper_methods
    coordinates_c = ["B1", "B2", "B3"]
    coordinates_s = ["B4", "B5"]

    assert_equal true, @board.valid_placement?(@cruiser, coordinates_c)
    assert_equal false, @board.valid_placement?(@submarine, coordinates_s)
  end

  def test_same_number_coords
    chosen_coords = ["A2", "B2", "C2"]
    chosen_coords2 = ["B1", "B2", "B3"]

    assert_equal true, @board.same_number_coords?(chosen_coords)
    assert_equal false, @board.same_number_coords?(chosen_coords2)
  end

  def test_vertical
    chosen_coords = ["A2", "B2", "C2"]
    expected_ordinal_array = [65, 66, 67]

    assert_equal expected_ordinal_array, @board.vertical(chosen_coords)
  end

  def test_possible_letter_coordinates_in_ordinal_values
    range = (65..68)
    length_1 = 3
    length_2 = 2
    expected_1 = [[65, 66, 67], [66, 67, 68]]
    expected_2 = [[65, 66], [66, 67], [67, 68]]

    assert_equal expected_1, @board.letter_coordinates_possible(range, length_1)
    assert_equal expected_2, @board.letter_coordinates_possible(range, length_2)
  end

  def test_chosen_coord_letters_are_in_possible_coordinates
    range = (65..68)
    length = 3
    chosen_coords = ["A2", "B2", "C2"]

    assert_equal true, @board.vertical_ok?(chosen_coords, range, length)
  end

  def test_valid_placement_same_number_and_helper_methods
    # cruiser = Ship.new("Cruiser", 3)
    # submarine = Ship.new("Submarine", 2)
    coordinates_c = ["B1", "C1", "D1"]
    coordinates_s_ok = ["C4", "D4"]
    coordinates_c_bad = ["C1", "D1", "E1"]
    coordinates_s_bad = ["D5", "E5"]

    assert_equal true, @board.valid_placement?(@cruiser, coordinates_c)
    assert_equal true, @board.valid_placement?(@submarine, coordinates_s_ok)
    assert_equal false, @board.valid_placement?(@cruiser, coordinates_c_bad)
    assert_equal false, @board.valid_placement?(@submarine, coordinates_s_bad)

  end

  def test_valid_placement_no_diagonal_plus_valid_placement
    # cruiser = Ship.new("Cruiser", 3)
    # submarine = Ship.new("Submarine", 2)

    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
    assert_equal true, @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])

  end

  def test_it_can_place_a_ship
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]

    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal @cruiser, @board.cells["A1"].ship
    assert_equal @cruiser, cell_2.ship
    assert_equal @cruiser, cell_3.ship

    # test cell is still a Cell
    assert_instance_of Cell, @board.cells["A1"]
    # make sure cell.ship = true
    assert_equal @cruiser, @board.cells["A1"].ship
  end

  def test_overlap?
    @board.place(@cruiser, ["A1", "A2", "A3"])

    placement_good = ["B1", "B2"]
    placement_bad  = ["A1", "B1"]

    assert_equal false, @board.overlap?(placement_good)
    assert_equal true, @board.overlap?(placement_bad)
  end

  def test_valid_placement_with_overlap_method
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal false, @board.valid_placement?(@submarine, ["A1", "B1"])
    assert_equal true, @board.valid_placement?(@submarine, ["B1", "B2"])

  end

  def test_top_string_render_board
  expected_top_row = "  1 2 3 4 "

  assert_equal expected_top_row, @board.top_row_render
  end

  def test_render_board
    @board.place(@cruiser, ["A1", "A2", "A3"])
    expected_board_string = "  1 2 3 4 \n" +
                          "A . . . . \n" +
                          "B . . . . \n" +
                          "C . . . . \n" +
                          "D . . . . \n"

    expected_show_true = "  1 2 3 4 \n" +
                        "A S S S . \n" +
                        "B . . . . \n" +
                        "C . . . . \n" +
                        "D . . . . \n"

    assert_equal expected_board_string, @board.render
    assert_equal expected_show_true, @board.render(true)
  end
end
