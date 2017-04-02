module MoviesHelper
  def render_movie_actor(movie)
    simple_format(movie.actor)
  end
end
