class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def edit
  end

  def create
    shelter = Shelter.find(params[:id])
    review = shelter.reviews.new(review_params)
    if review.valid?
      review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:alert] = "Please fill in Title, Rating, and Review."
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :picture)
  end
end
