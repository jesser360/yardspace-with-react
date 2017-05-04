class RemovePetsOrKidsFromBookings < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :pets_or_kids, :string
  end
end
