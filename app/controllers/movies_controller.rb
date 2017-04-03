class MoviesController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_movie_and_check_permission , only: [:edit, :update, :destroy]

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews.recent.paginate(:page => params[:page], :per_page => 5)
    @favorite = @movie.favorites
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user

    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @movie.update(movie_params)
    if @movie.save
      redirect_to movie_path(@movie), notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
      redirect_to movies_path, alert: "Movie Deleted"
  end

  def add_favorite
    @movie = Movie.find(params[:id])

    if !current_user.is_movie_member_of?(@movie)
      current_user.add_favorite!(@movie)
      flash[:notice] = "加入收藏成功！"
    else
      flash[:warning] = "你已经收藏此电影了！"
    end

    redirect_to movie_path(@movie)
  end

  def remove_favorite
    @movie = Movie.find(params[:id])

    if current_user.is_movie_member_of?(@movie)
      current_user.remove_favorite!(@movie)
      flash[:alert] = "已取消收藏！"
    else
      flash[:warning] = "你还没收藏过，怎么取消 XD"
    end

    redirect_to movie_path(@movie)
  end

private

  def find_movie_and_check_permission
    @movie = Movie.find(params[:id])

    if current_user != @movie.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def movie_params
    params.require(:movie).permit(:name,:date,:film_type,:film_time,:director,:actor,:imdb,:douban)
  end

end
