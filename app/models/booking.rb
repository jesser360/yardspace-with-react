class Booking < ApplicationRecord
  belongs_to :camper, :class_name => 'User'
  belongs_to :host, :class_name => 'User'
  belongs_to :yard
end
