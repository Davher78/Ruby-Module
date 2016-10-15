#require 'pry'

=begin
class Player

	def initialize (maze)		
		@lives = 5
		@position = 0

		# inicializamos el laberinto del jugador
		#@maze_player =[]
		#maze_player.each do |room|
		#	@maze_player.push(room)
		#end

	end

	def make_move door

	end

end
=end

class Room

	attr_reader(:north, :south, :east, :west)

	# Constructor de la clase
	def initialize (exit)
							
		@north = false
		@south = false
		@east = false
		@west = false
		@entry = ""

		if exit == "north"
			@north = true
		end

		if exit == "south"
			@south = true
		end

		if exit == "east"
			@east = true
		end

		if exit == "west"
			@west = true
		end
	end

	# Nos dice si la puerta es la salida
	def is_the_exit_door? door

		if self.send(door.to_sym)
			true
		else
			false
		end
	end

end

class Maze

	attr_reader :current_position

	def initialize (maze)

		# copiamos el array
		@maze =[]
		maze.each do |room|
			@maze.push(room)
		end
		@current_position = 0

	end

	def is_the_door? door
		
		if @maze[@current_position].is_the_exit_door? door

		 	@current_position += 1
			true

		 else
			false
		end

	end

	def is_the_exit?

		if @current_position == @maze.length
			true
		else
		    false
		end
	end
end


room1 = Room.new("north")
room2 = Room.new("south")
room3 = Room.new("east")
room4 = Room.new("west")

array_maze = [room1, room2, room3, room4]

# pry binding

maze1 = Maze.new(array_maze)

puts "Bienvenido al laberinto de 4 casillas"
while !maze1.is_the_exit?

	puts "Tu posicion actual es #{maze1.current_position}"
	puts "Introduce salida: north | south | east | west "
	salida = gets.chomp.to_s
	if maze1.is_the_door? salida
		puts "muy bien, has avanzado una posicion"
	else
		puts "Inténtalo de nuevo"
	end
end

puts "Enhorabuena!!! has acabado el laberinto"

