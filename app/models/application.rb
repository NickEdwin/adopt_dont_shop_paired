class Application < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :phone_number
  validates_presence_of :reason

  has_many :application_pets
  has_many :pets, through: :application_pets

  def find_app_pet(pet)
    self.application_pets.where(pet_id: pet.id)
  end

  def can_approve(pet)
    if pet.application_pets.where(approve: true) != []
      false
    else
      true
    end
  end

  def approve_for(pet)
    if can_approve(pet)
      find_app_pet(pet).map do |ap|
        ap.toggle_status
      end
    end
  end

  def can_unapprove(pet)
    find_app_pet(pet).any? do |ap|
      ap.approve == true
    end
  end
end
