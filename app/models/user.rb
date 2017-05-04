class User < ApplicationRecord
belongs_to :booking, optional: true
belongs_to :message, optional: true
has_many :yards
has_many :comments
end
