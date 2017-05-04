class AddZipCodeToYards < ActiveRecord::Migration[5.0]
  def change
    add_column :yards, :zipcode, :integer
    add_column :yards, :description, :text
    add_column :yards, :rating, :integer
    add_column :yards, :r_count, :integer
    add_column :yards, :safety, :integer
    add_column :yards, :kid_and_pet_friendly, :boolean
  end
end
