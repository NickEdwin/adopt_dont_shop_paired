class AddApproveToApplicationPets < ActiveRecord::Migration[5.1]
  def change
    add_column :application_pets, :approve, :boolean, default: false
  end
end
