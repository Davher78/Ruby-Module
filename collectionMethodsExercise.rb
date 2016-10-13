
class Home
  attr_reader(:name, :city, :capacity, :price)

  def initialize(name, city, capacity, price)
    @name = name
    @city = city
    @capacity = capacity
    @price = price
  end
end

homes = [
  Home.new("Nizar's place", "San Juan", 2, 42),
  Home.new("Fernando's place", "Seville", 5, 47),
  Home.new("Josh's place", "Pittsburgh", 3, 41),
  Home.new("Gonzalo's place", "Málaga", 2, 45),
  Home.new("Ariel's place", "San Juan", 4, 49),
  Home.new("2Nizar's place", "San Juan", 12, 420),
  Home.new("2Fernando's place", "Seville", 15, 470),
  Home.new("2Josh's place", "Pittsburgh", 13, 410),
  Home.new("2Gonzalo's place", "Málaga", 12, 450),
  Home.new("2Ariel's place", "San Juan", 14, 490)
]

puts homes[0].name
puts homes[1].name
puts homes[2].name
puts homes[3].name
puts homes[4].name

homes.each do |hm|
  puts hm.name
end

