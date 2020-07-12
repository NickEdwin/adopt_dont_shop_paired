class ApplicationsController < ApplicationController

  def new
    @fav_pet_objects = favorite.pet_objects
  end

  def create
    application = Application.new(application_params)

    pet_ids = params[:pet_ids]

    if application.save
      pet_ids.each do |id|
        ApplicationPet.new(application_id: application.id, pet_id: id)
        favorite.toggle(id.to_i)
      end
      redirect_to "/favorites"
      flash[:notice] = "Your application has been submitted."
    else
      flash[:errors] = application.errors.full_messages
      redirect_to "/applications/new"
    end
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :reason)
  end
end
