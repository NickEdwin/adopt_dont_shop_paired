class FavoritesController < ApplicationController

  def index
    if session[:fav_pets] != nil
      @fav_pet_objects = session[:fav_pets].map do |pet_id|
        Pet.find(pet_id)
      end
    else
    end
  end

  def update
    @pet = Pet.find(params[:pet_id])
    flash[:notice] = "Pet has been added to favorites list."
    session[:fav_pets] ||= []
    session[:fav_pets] << @pet.id
    redirect_to "/pets/#{@pet.id}"
  end
end
