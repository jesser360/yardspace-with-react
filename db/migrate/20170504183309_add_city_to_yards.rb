class AddCityToYards < ActiveRecord::Migration[5.0]
  def change
    add_column :yards, :city, :integer
  end
end
