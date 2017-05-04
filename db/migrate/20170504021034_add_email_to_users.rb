class AddEmailToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email, :string
    add_column :users, :age, :integer
    add_column :users, :bio, :text
    add_column :users, :is_hosting, :boolean
    add_column :users, :is_traveling, :boolean
    add_column :users, :gear, :text
  end
end
