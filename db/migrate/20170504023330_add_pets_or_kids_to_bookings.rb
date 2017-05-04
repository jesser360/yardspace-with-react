class AddPetsOrKidsToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :pets_or_kids, :boolean
  end
end
