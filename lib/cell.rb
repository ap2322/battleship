class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @cell_hit = false
    @render = "."
  end

  def empty?
    ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @cell_hit
  end

  def fire_upon
    ship.hit if ship
    @cell_hit = true
  end

  def render(show=false)
    if fired_upon? && ship == nil
      @render = "M"
    elsif show == true && !empty? && !fired_upon?
      @render = "S"
    elsif fired_upon? && ship.sunk?
      @render = "X"
    elsif fired_upon? && !empty?
      @render = "H"
    end
    @render
  end

end
