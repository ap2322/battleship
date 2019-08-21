class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @cell_hit = false
    @render = "."
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

  def render(show=false)
    if self.fired_upon? && @ship == nil
      @render = "M"
    elsif show == true && !self.empty?
      @render = "S"
    elsif self.fired_upon? && @ship.sunk?
      @render = "X"
    elsif self.fired_upon? && !self.empty?
      @render = "H"
    else
      @render = "."
    end
  end

end
