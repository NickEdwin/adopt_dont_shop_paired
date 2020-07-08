class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    new_pet = shelter.pets.new(pet_params)
    if new_pet.save
      redirect_to "/shelters/#{shelter.id}/pets"
    else
      flash[:errors] = new_pet.errors.full_messages
      redirect_to "/shelters/#{shelter.id}/pets/new"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    @pet.update(pet_params)
    redirect_to "/pets/#{@pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to "/pets"
  end

  private
  def pet_params
    params.permit(:name, :approx_age, :description, :sex, :image, :status)
  end

end
