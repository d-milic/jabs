# A migration for creating the users table in the database
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :first_name
      t.string :last_name
      t.string :password_digest, null: false

      t.timestamps null: false
    end
  end
end
