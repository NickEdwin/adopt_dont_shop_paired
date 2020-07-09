class FavoritesController < ApplicationController

  def index
    if session[:fav_pets] != nil
      @fav_pet_objects = favorite.pets.map do |pet_id|
        Pet.find(pet_id)
      end
    else
    end
  end

  def update
    @pet = Pet.find(params[:pet_id])
    flash[:notice] = "Pet has been added to favorites list."
    favorite.add_pet(@pet.id)
    session[:fav_pets] = favorite.pets
    redirect_to "/pets/#{@pet.id}"

    # REMOVE NEXT 2 LINES and use FAVORITE PORO
    # session[:fav_pets] ||= []
    # session[:fav_pets] << @pet.id
  end
end
