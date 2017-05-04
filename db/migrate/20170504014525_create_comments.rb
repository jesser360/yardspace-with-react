class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.references :yard, foreign_key: true
      t.timestamps
    end
  end
end
