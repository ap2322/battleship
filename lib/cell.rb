class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @cell_hit = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @cell_hit
  end

  def fired_upon
    if @ship
      @ship.hit
    end
    @cell_hit = true
  end
end
