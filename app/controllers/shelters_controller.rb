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
    if shelter.valid?
      shelter.save
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
    redirect_to "/shelters/#{@shelter.id}"
  end

  def destroy
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
    # params.require(:shelters).permit(:name, :address, :city, :state, :zip)
  end
end
