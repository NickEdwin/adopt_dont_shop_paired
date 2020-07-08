class ReviewsController < ApplicationController
  add_flash_types(:errors)

  def new
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
    @shelter = @review.shelter
  end

  def create
    shelter = Shelter.find(params[:id])
    review = shelter.reviews.new(review_params)
    if review.valid?
      review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:errors] = review.errors.full_messages
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  def update
    shelter = Review.find(params[:id]).shelter
    @review = Review.find(params[:id])
    @review.update(review_params)
    if @review.valid?
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:errors] = @review.errors.full_messages
      redirect_to "/reviews/#{@review.id}/edit"
    end
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :picture)
  end
end
