class AddDefaultToReviews < ActiveRecord::Migration[5.1]
  def change
    change_column :reviews, :picture, :string, :default => nil
  end
end
