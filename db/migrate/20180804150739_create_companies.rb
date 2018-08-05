class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :title, null: false
      t.string :slug, unique: true
      t.text :description
      t.boolean :enabled, default: false, null: false
      t.integer :comments_count, default: 0
      t.integer :views_count, default: 0
      t.integer :likes_count, default: 0
      t.string :phone, default: ''
      t.string :email, default: ''
      t.string :site, default: ''
      t.belongs_to :category
      t.timestamps
    end
  end
end
