
require "Imdb"

class Movie

	def self.search film
		movie = Imdb::Search.new(film)
		movie.movies[0].title
	end

end

class ASCII_Chart

a = [[1,2,3], [4,5,6], [7,8,9]]

	@file1 = [1,1,1,1,1,1,1,1,1,1]
	@file2 = ["|#|","|#|","|#|","|#|","|#|","|#|","|#|","|#|"," - "," 2 ",]

	def self.show film

		puts
		puts
		print "|#||#||#||#||#||#||#|"
		puts
		print "|#||#||#||#||#||#||#|"
		puts
		print "|#||#||#||#||#||#||#|"
		puts
		print "|#||#||#||#||#||#||#|"
		puts
		print "|#||#||#||#||#||#||#|"
		puts
		print "|#||#||#||#||#||#||#|"
		puts
		print "|#||#||#||#||#||#||#|"
		puts
		print "|#||#||#||#||#||#||#|"
		puts
		print "---------------------"
		puts
		print "|1||2||3||4||5||6||7|"
		puts
		
	end
end

films = ["Ghostbusters","Die Hard","The Godfather","Home alone","Star trek, the new generation","The night of the living dead","Titanic"]
search =[]

film =""
puts ASCII_Chart.show film

#films.each do |film|
#	puts Movie.search film 
#	puts ASCII_Chart.show film
#end

