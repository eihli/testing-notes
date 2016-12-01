class Application
  def self.run
    house = House.new
    house.paint(Colors.RED)
    Display.show(house)
  end
end
