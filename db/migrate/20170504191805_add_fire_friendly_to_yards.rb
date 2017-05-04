class AddFireFriendlyToYards < ActiveRecord::Migration[5.0]
  def change
    add_column :yards, :fire_friendly, :boolean
  end
end
