
class PriceList
	@@price_list = {"apple" => 10, "orange" => 5, "grapes" => 15, "banana" => 20,"watermelon" => 50 }
	def self.price_fruit fruit
		@@price_list[fruit.to_s]	
	end
end


class PriceDiscount 
	@@price_discount_quantity = {"apple" => 2, "orange" => 3, "grapes" => 4}
	# indica si la fruta tiene descuento
	def self.has_a_discount? fruit, quantity
		discount = false
		# si existe en la hash de descuentos
 		if @@price_discount_quantity.has_key?(fruit.to_s)
 			# si se han comprado los articulos suficientes
 			if quantity == @@price_discount_quantity[fruit.to_s] 
 				discount = true
 			end
 		end
 		discount
	end

end

class ShoppingCart
	
	def initialize
		@elements_price = {}
		@elements_quantity = {}
	end

	def discount_apple
		fruit = "apple"
		@elements_price[fruit.to_sym] = @elements_price[fruit.to_sym] - PriceList.price_fruit(fruit.to_s)
	end

	def discount_orange
		fruit = "orange"
		@elements_price[fruit.to_sym] = @elements_price[fruit.to_sym] - PriceList.price_fruit(fruit.to_s)
	end

	def discount_grapes

		fruit = "banana"
		puts "Do you want a banana for free? (si | no)"
		option = gets.chomp.to_s
		if option == "si"

			if @elements_price.has_key?(fruit.to_sym) 
				@elements_quantity[fruit.to_sym] += 1
			else
				@elements_quantity[fruit.to_sym] = 1
				@elements_price[fruit.to_sym] = 0
			end  
		end
	end

	def apply_discount fruit
			# mira si tiene descuento
			if PriceDiscount.has_a_discount? fruit, @elements_quantity[fruit]
				# si tiene descuento le decimos que ejecute la funcion descuento correspondiente
				self.send("discount_#{fruit.to_sym}")	
			end
	end


	def add_item_to_cart fruit	

		if @elements_price.has_key?(fruit)   

			@elements_price[fruit] = @elements_price[fruit] + PriceList.price_fruit(fruit)
			@elements_quantity[fruit] = @elements_quantity[fruit] + 1
			self.apply_discount fruit

		else

			@elements_quantity[fruit] = 1
			@elements_price[fruit] = PriceList.price_fruit(fruit)

		end

	end

	def show

		@elements_price.each do |key, value| 
			puts " #{@elements_quantity[key]} #{key} #{@elements_price[key]}" 
		end

	end

	def cost

		total = 0
		@elements_price.each_key do |key| 
			total += @elements_price[key]
		end
		puts "total cost: #{total}"

	end
end


cart = ShoppingCart.new

cart.add_item_to_cart :apple
cart.add_item_to_cart :apple
cart.add_item_to_cart :apple
cart.add_item_to_cart :banana
cart.add_item_to_cart :banana
cart.add_item_to_cart :orange
cart.add_item_to_cart :orange
cart.add_item_to_cart :orange
cart.add_item_to_cart :grapes
cart.add_item_to_cart :grapes
cart.add_item_to_cart :grapes
cart.add_item_to_cart :grapes

cart.show
cart.cost

#1 apple: 10$
#2 bananas: 40$

#cart.cost = 50