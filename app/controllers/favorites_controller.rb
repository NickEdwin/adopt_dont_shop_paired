class FavoritesController < ApplicationController

  def update
    @pet = Pet.find(params[:pet_id])
    redirect_to "/pets/#{@pet.id}"
  end
end
