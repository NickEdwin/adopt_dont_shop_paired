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
    if favorite.pets.include?(@pet.id)
      favorite.remove_pet(@pet.id)
      flash[:notice] = "Pet has been removed from favorites list."
    else
      favorite.add_pet(@pet.id)
      flash[:notice] = "Pet has been added to favorites list."
    end
    redirect_to "/pets/#{@pet.id}"

    # REMOVE NEXT 2 LINES and use FAVORITE PORO
    # session[:fav_pets] ||= []
    # session[:fav_pets] << @pet.id
  end

end
