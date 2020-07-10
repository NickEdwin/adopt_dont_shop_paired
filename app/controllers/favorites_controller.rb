class FavoritesController < ApplicationController

  def index
    if favorite.pets != nil
      @fav_pet_objects = favorite.pet_objects
    else
    end
  end

  def create
    @pet = Pet.find(params[:pet_id])
    favorite.toggle(@pet.id)
    flash[:notice] = "Pet has been added to favorites list."
    redirect_to "/pets/#{@pet.id}"
  end

  def destroy
    @pet = Pet.find(params[:pet_id])
    favorite.toggle(@pet.id)
    flash[:notice] = "Pet has been removed from favorites list."
    redirect_to "/pets/#{@pet.id}"
  end

end
