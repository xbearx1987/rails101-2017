class ReviewsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]
  before_action :find_review_and_check_permission , only: [:edit, :update, :destroy]

  def new
    @movie = Movie.find(params[:movie_id])
    @review = Review.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @review = Review.new(review_params)
    @review.movie = @movie
    @review.user = current_user

    if @review.save
      redirect_to movie_path(@movie)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @review.update(review_params)
    if @review.save
      redirect_to account_reviews_path, alert: 'Update Success'
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
      redirect_to account_reviews_path, alert: 'Review Deleted'
  end

private
  def find_review_and_check_permission
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])

    if current_user != @review.user
      redirect_to root_path, alert: "You have no permission."
    end
  end


  def review_params
    params.require(:review).permit(:content)
  end

end
