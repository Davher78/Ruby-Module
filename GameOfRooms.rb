#require 'pry'


class Player

	attr_reader(:lives, :current_position)

	def initialize maze	

		@lives = 5
		@current_position = 0
		@maze = maze

	end

	def make_move? door

		if @maze.is_the_door? @current_position, door
			@current_position += 1
			true
		else
			@lives -= 1
			false
		end
			
	end

	def is_dead?
		if @lives == 0
			true
		else
			false
		end
	end

	def is_the_exit?
		
		if @current_position == @maze.maze_length
			true
		else
		    false
		end
	end

end

class Room

	attr_reader(:north, :south, :east, :west)
	# Constructor de la clase
	def initialize (exit1, exit2)
							
		@north = false
		@south = false
		@east = false
		@west = false

		if exit1 == "north" || exit2 == "north"
			@north = true
		end

		if exit1 == "south" || exit2 == "south"
			@south = true
		end

		if exit1 == "east" || exit2 == "east"
			@east = true
		end

		if exit1 == "west" || exit2 == "west"
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

	def initialize (maze)

		# copiamos el array
		@maze =[]
		maze.each do |room|
			@maze.push(room)
		end
	end

	def is_the_door? position, door
		
		if @maze[position].is_the_exit_door? door
			true
		 else
			false
		end

	end

	def maze_length
		@maze.length
	end

end

room1 = Room.new("north","east")
room2 = Room.new("south","east")
room3 = Room.new("west","east")
room4 = Room.new("north","east")

array_maze = [room1, room2, room3, room4]

maze1 = Maze.new(array_maze)

jugador = Player.new(maze1)

# Control de la pantalla

puts "Bienvenido jugador al laberinto de 4 casillas"
puts "Tienes 5 vidas para llegar al final"
puts "Tu room actual es la #{jugador.current_position}"

while !jugador.is_dead? && !jugador.is_the_exit? 

	puts "Introduce salida: north | south | east | west "
	salida = gets.chomp.to_s

	if jugador.make_move? salida

		puts "--------------------------------------------------"
		puts "MUY BIEN!!!!, has avanzado una room"
		puts "Tu room actual es la #{jugador.current_position}"
		puts "Todavia te quedan #{jugador.lives} vidas"
		puts "--------------------------------------------------"

	else
		puts "--------------------------------------------------"
		puts "Inténtalo de nuevo"
		puts "Tu room actual es la #{jugador.current_position}"
		puts "Te quedan #{jugador.lives} vidas"
		puts "--------------------------------------------------"
	end
end

if jugador.is_dead?
	puts "-----------------------------------------------------------------------"
	puts "OHHHHHHHHHH!!! te has quedado sin vidas y no has terminado el laberinto"
	puts "-----------------------------------------------------------------------"
end

if jugador.is_the_exit?
	puts "------------------------------------------------------------"
	puts "ENHORABUENA!!!! has terminado el laberinto"
	puts "------------------------------------------------------------"
end
