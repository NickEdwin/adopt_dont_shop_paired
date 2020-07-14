class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def approve_app
    self.update(approve: true)
  end

end
