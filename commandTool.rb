

# definicion de modulo
module Usuarios

	# nos indica que todas las clases son privadas, es decir, no se pueden ver fuera del modulo
	private

	class User

		@@username ="david"
		@@password ="david"

		def self.check_password? (username, password)
			@@username == username && @@password == password	
		end

	end

	class CommandLine

		@@input_username =""
		@@input_password =""
		@@option =""

		def self.show_command_user
				puts "username"
				@@input_username = gets.chomp.to_s
				puts "password"
				@@input_password = gets.chomp.to_s
		end

		def self.show_menu
				puts "select an option: count_words | count_letters | reverse_the_text | convert_to_uppercase | convert_to_lowercase"
				@@option = gets.chomp.to_s
		end

		def self.control
			CommandLine.show_command_user
			if User.check_password?(@@input_username, @@input_password)
				CommandLine.show_menu
				Operator.send(@@option.to_sym)
			end
		end

	end

	class Operator

		def self.count_words
			puts "count_words"
		end

		def self.count_letters
			puts "count_letters"
		end

		def self.reverse_the_text
			puts "reverse_the_text"
		end

		def self.convert_to_uppercase
			puts "convert_to_uppercase"
		end

		def self.convert_to_lowercase
			puts "convert_to_lowercase"
		end

	end

	CommandLine.control
end
