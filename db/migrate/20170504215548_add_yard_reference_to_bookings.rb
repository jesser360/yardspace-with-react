class AddYardReferenceToBookings < ActiveRecord::Migration[5.0]
  def change
    add_reference :bookings, :yard, foreign_key: true
  end
end
