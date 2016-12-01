class House
  attr_reader :color, :available_colors

  def initialize(color = nil)
    @color = color
    @available_colors = [Colors.RED]
  end

  def paint(color)
    if @available_colors.contains(color)
      @color = color
    end
  end
end
