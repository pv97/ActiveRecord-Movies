# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#  id          :integer      not null, primary key
#  movie_id    :integer      not null
#  actor_id    :integer      not null
#  ord         :integer


def movie_names_before_1940
  # Find all the movies made before 1940. Show the id, title, and year.
  Movie.select('id, title, yr').where('yr < 1940')
end

def eighties_b_movies
	# List all the movies from 1980-1989 with scores falling between 3 and 5 (inclusive). Show the id, title, year, and score.
  Movie.select('id, title, yr, score').where(yr: (1980 .. 1989),score: (3..5))

end

def vanity_projects
  # List the title of all movies in which the director also appeared as the starring actor. Show the movie id and title and director's name.
  Movie.select('movies.id, movies.title, actors.name')
    .joins(:actors)
    .joins(:castings)
    .where('castings.ord = 1 AND actors.id = movies.director_id')
    .order('actors.name DESC').uniq
  # Note: Directors appear in the 'actors' table.

end

def starring(whazzername)
  puts whazzername
  puts whazzername.split("").join("%")
	# Find the movies with an actor who had a name like `whazzername`.
	# A name is like whazzername if the actor's name contains all of the letters in whazzername, ignoring case, in order.
  Movie.joins(:actors).where("actors.name ILIKE \'%#{whazzername.split("").join("%")}%\'").load

	# ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but not like "stallone sylvester" or "zylvester ztallone"

end

def bad_years
  # List the years in which a movie with a rating above 8 was not released.
  x = Movie.select('yr').group('yr').having('MAX(score) < 8')
  x.map { |ob| ob.yr }
end

def golden_age
	# Find the decade with the highest average movie score.
  yr = Movie.group('yr/10 * 10').order("AVG(score) DESC").limit(1)
  yr/10 * 10
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.  Sort the results by starring order (ord).
  Actor.joins(:movies).where(:movies => { title: title }).order("castings.ord").load
end

def costars(name)
  # List the names of the actors that the named actor has ever appeared with.
  x = Movie.joins(:actors).select(:movie_id).where(:actors => { name: name })
  Actor.joins(:movies).where("movies.id IN (?) AND actors.name != ?",x, name).uniq.pluck(:name)
end

def most_supportive
  # Find the two actors with the largest number of non-starring roles. Show each actor's id, name and number of supporting roles.

end

def what_was_that_one_with(those_actors)
	# Find the movies starring all `those_actors` (an array of actor names). Show each movie's title and id.

end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie

end

def longest_career
	#Find the actor and list all the movies of the actor who had the longest career (the greatest time between first and last movie).

end
