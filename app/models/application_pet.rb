class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def approve_app
    self.update(approve: true)
  end

  def unapprove
    self.update(approve: false)
  end

  def toggle
    if self.approve
      self.unapprove
    else
      self.approve_app
    end 
  end

end
