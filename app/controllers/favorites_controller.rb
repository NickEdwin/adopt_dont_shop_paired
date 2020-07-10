class FavoritesController < ApplicationController

  def index
    @fav_pet_objects = favorite.pet_objects if favorite.pets != nil
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
    redirect_back(fallback_location:"/favorites")
  end

  def destroy_all
    favorite.pets.clear
    redirect_back(fallback_location:"/favorites")
  end

  def new
    @fav_pet_objects = favorite.pet_objects
  end
end
