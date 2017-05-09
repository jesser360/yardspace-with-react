class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.boolean :is_accepted
      t.belongs_to :me, :class_name => 'User'
      t.belongs_to :you, :class_name => 'User'
      t.timestamps
    end
  end
end
