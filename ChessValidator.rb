
class Board

	# damos acceso  de lectura escritura a las variables width y height
	attr_accessor(:width, :height, :board)

	# creamos un board inicial
	def initialize

		@width = 8
		@height = 8
		@board = Array.new(@height){Array.new(@width)}

		# inicializamos en board con guiones (vacio
		for file in (0..@width-1)
			for column in (0..@height-1)
				@board[file][column] = "--"
			end
		end
	end

	#colocamos las figuras en la posicion de salida
	def format_board

		# formateamos la primera fila de negras
		@board[0][0] = "bR"
		@board[0][1] = "bN"
		@board[0][2] = "bB"
		@board[0][3] = "bQ"
		@board[0][4] = "bK"
		@board[0][5] = "bB"
		@board[0][6] = "bN"
		@board[0][7] = "bR"

		# formateamos los peones de negras
		for column in (0..@height-1)
				@board[1][column] = "bP"
		end

		# formateamos los peones de blancas
		for column in (0..@height-1)
				@board[6][column] = "wP"
		end

		# formateamos la primera fila de negras
		@board[7][0] = "wR"
		@board[7][1] = "wN"
		@board[7][2] = "wB"
		@board[7][3] = "wQ"
		@board[7][4] = "wK"
		@board[7][5] = "wB"
		@board[7][6] = "wN"
		@board[7][7] = "wR"

	end

	# leemos un tablero de fichero
	def read_board new_board
		fila = 0
		new_board.each do |line|
			columna = 0
			columns = line.split(" ")
			columns.each do |celd|
				@board[fila][columna] = celd
				columna += 1
			end
			fila += 1
		end
	end

	# comprobamos que las coordenadas estan dentro de los limites del tablero
	def is_in_limits? coordinate
		((coordinate[0][0] < @width) && (coordinate[0][1] < @height) && (coordinate[1][0] < @width) && (coordinate[1][1] < @height))
	end

	# escribimos el array por pantalla
	def print_board
		for file in (0..@width)
			print @board[file]
			puts
		end
	end
 
	
end

class ChessValidator

	def initialize new_board
		# creamos una validador del tablero
		@board = new_board
	end

	def move_valid? coordinate
		# miramos si las coordenadas estan dentro de los limites del tablero
		# miramos si la pieza de las coordenadas puede hacer el movimiento en el tablero
		((@board.is_in_limits? coordinate) && (Piece.is_a_move_valid? @board, coordinate) )				
	end

end

class Piece

	def self.is_a_move_valid? current_board, coordenate

		# coordenadas de la coordenada origen"
		fil = coordenate[0][0]
		col = coordenate[0][1]

		# vemos que pieza está en esa coordenada
		current_piece = current_board.board[fil][col]
		
		# generamos un array que contiene el color y el tipo de pieza
		type = current_piece.split(//)

		# llamar al metodo dependiendo del tipo de pieza
		if type[1]== "R"
			Rook.is_a_move_valid? current_board, coordenate, type[0]
		elsif type[1]== "N"
			Horse.is_a_move_valid? current_board, coordenate, type[0]
		elsif type[1]== "B"
			Bishop.is_a_move_valid? current_board, coordenate, type[0]
		elsif type[1]== "Q"
			Queen.is_a_move_valid? current_board, coordenate, type[0]
		elsif type[1]== "K"
			King.is_a_move_valid? current_board, coordenate, type[0]
		elsif type[1]== "P"
			Pawn.is_a_move_valid? current_board, coordenate, type[0]
		elsif type[1]== "-"
			false
		end
	end

end

class Rook < Piece
	def self.is_a_move_valid? current_board, coordenate, colour

		#coordenada origen
		origin_fil = coordenate[0][0]
		origin_col = coordenate[0][1]

		# coordenado destino
		des_fil = coordenate[1][0]
		des_col = coordenate[1][1]

		# comprobamos que la posicion final está vacia
		(current_board.board[des_fil][des_col] == "--") &&
		# comprobamos que sea la misma fila o la misma columna
		((origin_fil == des_fil) || (origin_col == des_col))

	end
end

class Horse < Piece
	def self.is_a_move_valid? current_board, coordenate, colour
		#coordenada origen
		origin_fil = coordenate[0][0]
		origin_col = coordenate[0][1]

		# coordenado destino
		des_fil = coordenate[1][0]
		des_col = coordenate[1][1]

		# comprobamos que la posicion final está vacia
		final = (current_board.board[des_fil][des_col] == "--")

		# comprobamos que es la misma columna +2 y fila+1
		# misma_columna = (origin_col == des_col)
		distancia_columna = ((origin_col - des_col).abs == 2)
		distancia_fila = ((origin_fil - des_fil).abs == 1)
		mov_vertical = distancia_columna && distancia_fila

		# o comprobamos que es la misma fila +2 y columna+1
		#misma_fila = (origin_fil == des_fil)
		distancia_fila = ((origin_fil - des_fil).abs == 2)
		distancia_columna = ((origin_col - des_col).abs == 1)
		mov_horizontal = distancia_fila && distancia_columna

		(final && (mov_vertical || mov_horizontal))
	end
end

class Bishop < Piece
	def self.is_a_move_valid? current_board, coordenate, colour

		#coordenada origen
		origin_fil = coordenate[0][0]
		origin_col = coordenate[0][1]

		# coordenado destino
		des_fil = coordenate[1][0]
		des_col = coordenate[1][1]

		# comprobamos que la posicion final está vacia
		(current_board.board[des_fil][des_col] == "--") &&
		# comprobamos el movimiento diagonal
		# la distancia entre filas y columnas debe ser la misma
		((origin_fil - des_fil).abs == (origin_col - des_col).abs)

	end
end

class Queen < Piece
	def self.is_a_move_valid? current_board, coordenate, colour
		
		#coordenada origen
		origin_fil = coordenate[0][0]
		origin_col = coordenate[0][1]

		# coordenado destino
		des_fil = coordenate[1][0]
		des_col = coordenate[1][1]

		# comprobamos que la posicion final está vacia
		(current_board.board[des_fil][des_col] == "--") &&

		# comprobamos el movimiento diagonal
		# la distancia entre filas y columnas debe ser la misma
		(((origin_fil - des_fil).abs == (origin_col - des_col).abs) ||
		# o es movimiento recto
		# comprobamos que sea la misma fila o la misma columna
		((origin_fil == des_fil) || (origin_col == des_col)))

	end
end

class King < Piece
	def self.is_a_move_valid? current_board, coordenate, colour

		#coordenada origen
		origin_fil = coordenate[0][0]
		origin_col = coordenate[0][1]

		# coordenado destino
		des_fil = coordenate[1][0]
		des_col = coordenate[1][1]

		# comprobamos que la posicion final está vacia
		final = (current_board.board[des_fil][des_col] == "--")

		# comprobamos el movimiento diagonal
		# la distancia entre filas y columnas debe ser la misma
		diagonal = ((origin_fil - des_fil).abs == (origin_col - des_col).abs )
		# comprobamos que la distancia diagonal es 1
		distancia_diagonal = ((origin_fil - des_fil).abs == 1)

		# o es movimiento recto
		# comprobamos que sea la misma fila con distancia 1
		recto_fil = ((origin_fil == des_fil) && ((origin_fil - des_fil).abs == 1)) 
		# o es la misma columna con distancia 1
		recto_col = ((origin_col == des_col) && ((origin_col - des_col).abs == 1)) 

		# resultado
		(final && ( (diagonal && distancia_diagonal) || (recto_fil || recto_col) ))

	end
end

class Pawn < Piece
	def self.is_a_move_valid? current_board, coordenate, colour

		#coordenada origen
		origin_fil = coordenate[0][0]
		origin_col = coordenate[0][1]

		# coordenado destino
		des_fil = coordenate[1][0]
		des_col = coordenate[1][1]

		# La última posición está vacia??
		final = (current_board.board[des_fil][des_col] == "--")

		# es un movimiento recto en la columna??
		recto_fil = (origin_col == des_col) 

		# miramos la distancia entre las filas
		distancia = origin_fil - des_fil

		# se corresponde con el color 
		correspondencia = (((distancia == 1) && (colour == "w")) ||
		((distancia == -1) && (colour == "b")))

		# si esta en la posicion de salida puede mover 2 a la vez
		posicion_salida_b = (origin_fil == 1) && (colour == "b") && (distancia == -2)
		posicion_salida_w = (origin_fil == 6) && (colour == "w") && (distancia == 2)

		(final && recto_fil && (correspondencia || posicion_salida_w || posicion_salida_b))

	end
end

class Transform

	def self.coords coordinate

		width = 2
		height = 2
		transformation = Array.new(height){Array.new(width)}

		array_coordinate = coordinate.split(//)
		
		# convertimos la letra origen
		transformation[0][1] = self.calc_coordx array_coordinate[0]
		# convertimos el numero origen 
		transformation[0][0] = self.calc_coordy array_coordinate[1]

		# convertimos la letra destino
		transformation[1][1] = self.calc_coordx array_coordinate[3]
		# convertimos el numero destino
		transformation[1][0] = self.calc_coordy array_coordinate[4]
		
		transformation
	 	# transfomation = [[0,1],[2,0]]
	end 

	def self.calc_coordx coordx
		coordx.ord - 97
	end
	def self.calc_coordy coordy
		new_coordy = 8 - coordy.to_i
	end
end

class ChessFile

	def self.read chess_input_file
		File.new(chess_input_file)
	end

	def self.board chess_output_file
		File.open(chess_output_file, 'w')
	end

	def self.write board, content
		board.puts content
	end

end

# creamos un tablero
tablero = Board.new

# leemos el fichero con el tablero
new_board = ChessFile.read "./complex_board.txt"

# formateamos el tablero a la posicion inicial
#tablero.format_board

# Cargamos el tablero del fichero
tablero.read_board new_board

# dibujamos en pantalla el tablero
tablero.print_board

# creamos un validador de tablero
validador = ChessValidator.new(tablero)

# leemos jugadas de fichero
simple_moves = ChessFile.read "./complex_moves.txt"

# creamos fichero de resultados
simple_board = ChessFile.board "./complex_results.txt"

# comprobamos las coordenadas del fichero
simple_moves.each do |coordinate|

	# transformamos a coordenadas internas
	new_coordinate = Transform.coords coordinate
	
	# validamos las jugadas
	result = "ILLEGAL"
	if validador.move_valid? new_coordinate
		result = "LEGAL"
	end

	# mostramos por pantalla
	puts "coordenada fichero: #{coordinate.chomp.to_s} --> #{new_coordinate} --> result:#{result}" 

	# escribimos el resultado en el fichero
	ChessFile.write simple_board, result


end


