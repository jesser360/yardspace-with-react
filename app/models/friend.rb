class Friend < ApplicationRecord
  belongs_to :me, :class_name => 'User'
  belongs_to :you, :class_name => 'User'
end
