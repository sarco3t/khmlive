class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :title
      t.belongs_to :category, foreign_key: true
      t.string :link
      t.integer :position
      t.timestamps
    end
    add_column :menus, :ancestry, :string
    add_index :menus, :ancestry

  end
end
