class ApplicationPetsController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    approve_for(pet)
  end
end
