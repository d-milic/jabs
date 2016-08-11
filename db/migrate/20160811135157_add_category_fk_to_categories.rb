class AddCategoryFkToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :parent_category,
                  references: :categories, index: true
    add_foreign_key :categories, :categories, column: :parent_category_id
  end
end
