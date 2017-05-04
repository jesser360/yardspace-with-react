class AddEndDateToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :end_date, :string
    add_column :bookings, :is_accepted, :boolean
    add_column :bookings, :is_answered, :boolean
    add_column :bookings, :group_size, :integer
    add_column :bookings, :pets_or_kids, :string
    add_column :bookings, :boolean, :string
  end
end
