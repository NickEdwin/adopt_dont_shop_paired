class Shelter < ApplicationRecord
  validates_presence_of :name
  # validates_presence_of :address, :city, :state, :zip
  has_many :pets, :reviews

  def self.sort_alphabetically
    all.sort_by { |shelter| shelter.name }
  end

  def self.sort_pet_count
    all.sort_by { |shelter| shelter.pets.count }.reverse
  end
end
