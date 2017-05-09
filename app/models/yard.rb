class Yard < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :bookings

  enum city: [:sf_bay_area, :santa_cruz, :lake_tahoe, :yosemite, :santa_barbara, :sonoma, :los_angeles]
end
