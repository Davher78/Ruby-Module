
class Player

	attr_reader(:lives, :current_position, :player_objects)
	def initialize maze	
		@lives = 5
		@current_position = 0
		@maze = maze
		@player_objects = []
	end

	# Realiza un movimiento y devuelve positivo si el jugador avanza 
	def make_move? door
		if @maze.is_the_door? @current_position, door
			@current_position += 1
			true
		else
			@lives -= 1
			false
		end
	end

	# incluye un nuevo objeto al array de objetos del jugador
	def put_object object
		@player_objects.push(object)
	end

	# elimina una vida 
	def takes_a_life
			@lives -= 1
	end

	# comprueba si al jugador todavia le quedan vidas	
	def is_dead?
		if @lives == 0
			true
		else
			false
		end
	end

	# comprueba si el jugador ha llegado al final del laberinto
	def is_the_exit?
		if @current_position == @maze.maze_length
			true
		else
		    false
		end
	end
end

# la class Room solo se usa por laberinto
class Room

	attr_reader(:north, :south, :east, :west, :characteristic, :objects, :item_needed)
	
	# Constructor de la clase
	def initialize (exit1, exit2, characteristic, objects, item_needed)
							
		@north = false
		@south = false
		@east = false
		@west = false
		@characteristic = characteristic
		@objects = objects
		@item_needed = item_needed

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

	# Nos dice si la puerta (door) es la salida
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
		@maze = maze
	end

	# comprobamos si la puerta de la room es una salida
	def is_the_door? position, door
		if @maze[position].is_the_exit_door? door
			true
		 else
			false
		end

	end

	# nos devuelve la descripcion de la room indicada en posicion
	def door_description position
		@maze[position].characteristic
	end

	# nos devuelve los objetos que se pueden seleccionar en la room indicada en posicion
	def door_objects position
		@maze[position].objects
	end

	# nos devuelve el objeto necesario de la room indicada en posicion
	def door_item_needed position
		@maze[position].item_needed
	end

	# nos devuelve la longitud del laberinto
	def maze_length
		@maze.length
	end
end


# creamos los objetos de cada room
objects1 = ["agua","flechas"]
objects2 = ["escudo","armadura"]
objects3 = ["antorcha","caballo"]
objects4 = ["balsa","gema"]

# creamos las rooms
room1 = Room.new("north","east", "AGUA", objects1, "")
room2 = Room.new("south","east", "FUEGO", objects2, "agua")
room3 = Room.new("west","east", "VIENTO", objects3, "escudo")
room4 = Room.new("north","east", "MIEDO", objects4, "antorcha")

# creamos un array de rooms
array_maze = [room1, room2, room3, room4]

# creamos el laberinto
maze1 = Maze.new(array_maze)

# creamos un jugador
jugador = Player.new(maze1)

# PANTALLA

puts "----------------------------------------------------------------------------------"
puts "BIENVENIDO JUGADOR DEL LABERINTO"
puts "TIENES 5 VIDAS PARA COMPLETARLO"
puts "COMIENZAS EN LA HABITACION DEL #{maze1.door_description jugador.current_position}"
puts "----------------------------------------------------------------------------------"
puts "EN TODAS LAS HABITACIONES ENCONTRARÁS OBJETOS QUE TE AYUDARAN A LO LARGO DEL CAMINO"
puts "ELIGE BIEN YA QUE DE ELLO DEPENDERA TU VIDA"
puts "LA HABITACION ACTUAL TIENE LOS SIGUIENTES OBJETOS: "
puts "#{maze1.door_objects jugador.current_position }"
puts "SELECCIONA UNO: "
player_object = gets.chomp.to_s
jugador.put_object player_object
puts "BUENA ELECCION!, TU LISTA DE OBJETOS ACTUAL ES: #{jugador.player_objects}"
puts "----------------------------------------------------------------------------------"

# MIENTRAS EL JUGADOR NO ESTE MUERTO Y NO SE HAYA ENCONTRADO LA SALIDA
while !jugador.is_dead? && !jugador.is_the_exit? 

	puts "ELIGE UNA PUERTA PARA AVANZAR POR EL LABERINTO: north | south | east | west "
	salida = gets.chomp.to_s


	if jugador.make_move? salida

		puts "--------------------------------------------------------------------------"
		puts "MUY BIEN JUGADOR!!!, HAS SELECCIONADO UNA PUERTA CORRECTA"
		puts "--------------------------------------------------------------------------"

		# SI YA HA ENCONTRADO LA SALIDA NO SE MUESTRAN MAS MENSAJES HASTA LA SALIDA DEL WHILE
		if !jugador.is_the_exit? 
		
				puts "HAS CONSEGUIDO AVANZAR A LA HABITACION DEL #{maze1.door_description jugador.current_position }"

				# comprobamos si el jugador tiene el objeto necesario para la habitacion
				existe = false
				jugador.player_objects.each do |item|

					if item == (maze1.door_item_needed jugador.current_position)
						existe = true
					end
				end

				if existe
					puts " Y GRACIAS A TU OBJETO: #{maze1.door_item_needed jugador.current_position}"
					puts " HAS PODIDO PERMANECER CON VIDA"
					
				else
					puts " PERO NO DISPONIAS DEL OBJETO: #{maze1.door_item_needed jugador.current_position} PARA SOBREVIVIR EN ESTA HABITACION"
					puts " Y TE HA COSTADO UNA VIDA. LA PROXIMA VEZ SELECCIONA MEJOR TUS OBJETOS"
					# le quitamos una vida
					jugador.takes_a_life
				end
				puts "----------------------------------------------------------------------------------"
				puts "SIGUE JUGANDO, TODAVIA DISPONES DE #{jugador.lives} VIDAS"
				puts "--------------------------------------------------"

				puts "EN LA HABITACION ACTUAL PUEDES ESCOGER ENTRE LOS SIGUIENTES OBJETOS: "
				puts "#{maze1.door_objects jugador.current_position }"
				puts "SELECCIONA UNO: "
				player_object = gets.chomp.to_s
				jugador.put_object player_object
				puts "BUENA ELECCION!, TU LISTA DE OBJETOS ACTUAL ES: #{jugador.player_objects}"
				puts "--------------------------------------------------"
		end

	else
				puts "--------------------------------------------------"
				puts "UUPS, NO ES UNA SALIDA CORRECTA Y TE HA COSTADO UNA VIDA"
				puts "SIGUES EN LA HABITACION DEL #{maze1.door_description jugador.current_position}"
				puts "--------------------------------------------------"
				puts "SELECCIONA MEJOR YA QUE SOLO TE QUEDAN #{jugador.lives} VIDAS"
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
