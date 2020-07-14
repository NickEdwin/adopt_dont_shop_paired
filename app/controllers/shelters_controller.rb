class SheltersController < ApplicationController
  # add before_action :set_article, only:
  # like a setup, so our code is DRY
  # look in Blogger under Edit Action & View

  def index
    @shelters = Shelter.all
    @alpha_shelters = Shelter.sort_alphabetically
    @pet_count_shelters = Shelter.sort_pet_count
  end

  def show
    @shelter = Shelter.find(params[:id])
    @reviews = @shelter.reviews
  end

  def new

  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      redirect_to "/shelters"
    else
      flash[:errors] = shelter.errors.full_messages
      redirect_to "/shelters/new"
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    @shelter.update(shelter_params)
    if @shelter.valid?
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:errors] = @shelter.errors.full_messages
      redirect_to "/shelters/#{@shelter.id}/edit"
    end
  end

  def destroy
    ids_to_delete = Shelter.find(params[:id]).pets.ids
    ids_to_delete.each do |id|
      favorite.pets.delete(id)
    end
    Shelter.destroy(params[:id])
    redirect_to "/shelters"
  end

  def pets_index
    @shelter = Shelter.find(params[:shelter_id])
    @pets = @shelter.pets
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
