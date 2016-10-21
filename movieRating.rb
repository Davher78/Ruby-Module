
require "Imdb"

films = ["Ghostbusters","Die Hard","The Godfather","Home alone","Star trek, the new generation","The night of the living dead","Titanic"]

#busqueda = Imdb::Search.new("Die Hard")
#puts busqueda.movies[0].title

search =[]

films.each do |film|

	search.push(Imdb::Search.new(film))

end

search.each do |seo|

	puts seo.movies[0].title

end





