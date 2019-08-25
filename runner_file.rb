require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'
require './lib/player'
require 'pry'

def start
  puts "Welcome to BATTLESHIP"
  puts "Enter p to play. Enter q to quit."
  p_or_q = gets.chomp
    if p_or_q.downcase == "p"
      make_board_and_ships
      computer_starts
      player_starts
    elsif p_or_q.downcase == "q"
      abort "Goodbye"
    else "Please enter p or q."
    end
end

def make_board_and_ships
  @board_comp = Board.new
  @board_user = Board.new
  @cruiser = Ship.new("Cruiser", 3)
  @submarine = Ship.new("Submarine", 2)
  @all_ships = [@cruiser, @submarine]
end

def computer_starts
  @comp1 = Computer.new
  @comp1.place_all_ships(@board_comp, @all_ships)
end

def player_starts
  @player = Player.new
  puts "You now need to lay out your two ships."
  puts "The Cruiser is three units long and the Submarine is two units long."
  puts @board_user.render
  puts "Enter the squares for the cruiser (3 spaces):"
  print ">"
  player_placement = gets.chomp
  placement =  @player.string_placement_to_array(player_placement)
  @player.place_on_board(@cruiser, @board_user, placement)
  puts @board_user.render(true)
  puts "Enter the squares for the submarine (2 spaces):"
  print ">"
  player_placement = gets.chomp
  placement =  @player.string_placement_to_array(player_placement)
  @player.place_on_board(@submarine, @board_user, placement)
  puts @board_user.render(true)

end

start