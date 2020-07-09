class FavoritesController < ApplicationController

  def index
    if session[:fav_pets] != nil
      @fav_pet_objects = session[:fav_pets].map do |pet_id|
        Pet.find(pet_id)
      end
    else
    end




    # @fav_images = session[:fav_pets_images]
    # @fav_ids = session[:fav_pets_ids]
  end

  def update
    @pet = Pet.find(params[:pet_id])
    flash[:notice] = "Pet has been added to favorites list."
    session[:fav_pets] ||= []
    session[:fav_pets] << @pet.id
    redirect_to "/pets/#{@pet.id}"


    # session[:fav_pets_images] ||= Hash.new
    # session[:fav_pets_images][@pet.name] = @pet.image
    # session[:fav_pets_ids] ||= Hash.new
    # session[:fav_pets_ids][@pet.name] = @pet.id
  end
end

# --- for future refactoring ---
# session[:fav_pets] = [3, 54, 2] (<~ store the ids in an array)
# @current_pet = AR.find pet[:id] (<~ use the ids in an AR search to locate pet)
# @current_pet.name (<~ then we have ac cess to these things)
# @current_pet.image
# @current_pet.id
