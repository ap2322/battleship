
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
  @board_player = Board.new
  @cruiser_c = Ship.new("Cruiser", 3)
  @submarine_c = Ship.new("Submarine", 2)
  @cruiser_p = Ship.new("Cruiser", 3)
  @submarine_p = Ship.new("Submarine", 2)
  @all_ships_c = [@cruiser_c, @submarine_c]
  @all_ships_p = [@cruiser_p, @submarine_p]
end

def computer_starts
  @comp1 = Computer.new
  @comp1.place_all_ships(@board_comp, @all_ships_c)
end

def player_starts
  @player = Player.new
  puts "==============PLAYER TURN=============="
  puts "You now need to lay out your two ships."
  puts "The Cruiser is three units long and the Submarine is two units long."
  puts @board_player.render
  puts "Enter the squares for the cruiser (3 spaces):"
  print ">"
  @player.string_placement_to_array
  @player.place_on_board(@cruiser_p, @board_player)
  puts @board_player.render(true)
  puts "Enter the squares for the submarine (2 spaces):"
  print ">"
  @player.string_placement_to_array
  @player.place_on_board(@submarine_p, @board_player)
  # start turns
  take_turns
end

def ships_all_sunk(ships)
  # helper ships_all_sunk(ships) method, returns boolean
  # can only run this method after ships are placed

  ships.all? {|ship| ship.health == 0}
end

def take_turns
  # Repeats <show board> <take shots> <show result>
  # until either the computer's ships are sunk or the player's ships are sunk
  until ships_all_sunk(@all_ships_c) || ships_all_sunk(@all_ships_p)
    turn
  end
  game_over_sequence
end

def turn
  puts "=============COMPUTER BOARD============="
  puts @board_comp.render
  puts "==============PLAYER BOARD=============="
  puts @board_player.render(true)
  puts "Enter the coordinate for your shot:"
  print ">"
  # shot = gets.chomp
  @player.take_shot(@board_comp)
  # computer takes shot
  @comp1.take_shot(@board_player)
  # puts results of turn
  player_results(@player.shots_taken.last)
  comp_results(@comp1.shots_taken.last)
end

def player_results(player_shot)
  # if player shot was a hit and ship at cell shot sunk -> "Your shot was a hit, and sunk a #ship"
  if @board_comp.cells[player_shot].render == "X"
    puts "Your shot at #{player_shot} was a hit, and sunk my #{@board_comp.cells[player_shot].ship.name}."
  # if player shot miss -> "Your shot on #{player_shot} was a miss."
  elsif @board_comp.cells[player_shot].render == "M"
    puts "Your shot at #{player_shot} was a miss."
  # if player shot was a hit -> "Your shot on player shot was a hit"
  elsif @board_comp.cells[player_shot].render == "H"
    puts "Your shot at #{player_shot} was a hit."
  end
end
# make one results(shot, board)
#

def comp_results(comp_shot)

  if @board_player.cells[comp_shot].render == "X"
    puts "My shot at #{comp_shot} was a hit, and sunk your #{@board_player.cells[comp_shot].ship.name}."
  # if player shot miss -> "Your shot on #{player_shot} was a miss."
  elsif @board_player.cells[comp_shot].render == "M"
    puts "My shot at #{comp_shot} was a miss."
  # if comp shot was a hit -> "Your shot on comp shot was a hit"
  elsif @board_player.cells[comp_shot].render == "H"
    puts "My shot at #{comp_shot} was a hit."
  end
  # binding.pry
end

def game_over_sequence
  if ships_all_sunk(@all_ships_c)
    puts "You won!"
  elsif ships_all_sunk(@all_ships_p)
    puts "I won ya bozo!"
  end
  start
end


start
