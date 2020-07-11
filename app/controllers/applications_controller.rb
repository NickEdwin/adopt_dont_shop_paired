class ApplicationsController < ApplicationController

  def new
    @fav_pet_objects = favorite.pet_objects
  end

  def create
    # can't implement flash.now notice until we create
    # Application model to check form field validations
    # then we can do an if/else like we did in shelters#create

    # app = Application.new(app_params)
    # flash.now[:notice] = "Your application has been submitted."
    redirect_to "/favorites"
  end
end
