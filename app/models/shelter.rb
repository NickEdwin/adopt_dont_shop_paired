class Shelter < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  has_many :pets
  has_many :reviews

  def self.sort_alphabetically
    all.sort_by { |shelter| shelter.name }
  end

  def self.sort_pet_count
    all.sort_by { |shelter| shelter.pets.count }.reverse
  end

  def num_of_pets
    self.pets.count
  end

  def average_rating
    if self.reviews.any?
      self.reviews.average(:rating)
    else
      0
    end
  end

  def num_of_applications
    self.pets.sum do |pet|
      pet.applications.count
    end
  end
end
