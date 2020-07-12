class Pet < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :approx_age
  validates_presence_of :sex
  validates_presence_of :shelter
  # validates_presence_of :status
  belongs_to :shelter
  has_many :application_pets
  has_many :application, through: :application_pets
end
