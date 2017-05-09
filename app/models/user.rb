class User < ApplicationRecord
belongs_to :booking, optional: true
belongs_to :message, optional: true
belongs_to :friend, optional: true
has_many :yards
has_many :comments

has_secure_password

validates :email, presence: true,
uniqueness: { case_sensitive: false },
length: { minimum: 3, maximum: 25 }

validates :name, presence: true,
length: { minimum: 3, maximum: 25 }

validates :password, presence: true,
length: { minimum: 3, maximum: 25 }, on: :create
end
