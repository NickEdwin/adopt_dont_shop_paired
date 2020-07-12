class ApplicationsController < ApplicationController

  def new
    @fav_pet_objects = favorite.pet_objects
  end

  def create
    application = Application.new(application_params)
    params[:pets].each do |id|
      pet = Pet.find(id)
      require"pry"; binding.pry
      ApplicationPet.new(application: application.id ,pet: pet.id)
      if application.save
        flash.now[:notice] = "Your application has been submitted."
        redirect_to "/favorites"
      else
        flash[:errors] = application.errors.full_messages
        redirect_to "/applications/new"
      end
    end
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :reason)
  end
end
