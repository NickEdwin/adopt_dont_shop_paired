class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :approx_age
      t.string :sex
      t.references :shelter, foreign_key: true
      t.string :image
      t.timestamps
    end
  end
end
