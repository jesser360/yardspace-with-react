class RemoveBooleanFromBookings < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :boolean, :string
  end
end
