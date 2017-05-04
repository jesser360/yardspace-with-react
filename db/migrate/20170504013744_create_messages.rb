class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :message
      t.belongs_to :sender, :class_name => 'User'
      t.belongs_to :receiver, :class_name => 'User'
      t.timestamps
    end
  end
end
