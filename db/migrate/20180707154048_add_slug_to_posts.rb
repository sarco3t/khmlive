class AddSlugToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :slug, :string
    add_column :categories, :slug, :string, null: false
    add_index :posts, :slug, unique: true
    add_index :categories, :slug, unique: true
  end
end
