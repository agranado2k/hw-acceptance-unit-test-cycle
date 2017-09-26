class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.search_directors(movie)
    @movies = Movie.where(director: movie.director).where.not(title: movie.title)
  end
end
