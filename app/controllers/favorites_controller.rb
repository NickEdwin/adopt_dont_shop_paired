class FavoritesController < ApplicationController

  def index
  end

  def update
    @pet = Pet.find(params[:pet_id])
    redirect_to "/pets/#{@pet.id}"
    flash[:notice] = "Pet has been added to favorites list."
    session[:counter] ||= 0
    session[:counter] += 1
  end
end
