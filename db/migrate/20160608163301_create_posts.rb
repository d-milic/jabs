# A migration for creating the posts table in the database
class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false

      t.timestamps null: false
    end
    add_reference :posts, :user, index: true, foreign_key: true
    add_reference :posts, :category, index: true, foreign_key: true
  end
end
