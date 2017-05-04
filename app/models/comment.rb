class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :yard
end
