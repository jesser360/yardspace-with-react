class AddImageToYards < ActiveRecord::Migration[5.0]
  def change
    add_column :yards, :image, :string
  end
end
