class RemoveStatusFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :status, :string
  end
end
