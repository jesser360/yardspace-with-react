class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.string :start_date
      t.belongs_to :camper, :class_name => 'User'
      t.belongs_to :host, :class_name => 'User'
      t.timestamps
    end
  end
end
