class AddIconToMenus < ActiveRecord::Migration[5.2]
  def change
    add_column :menus, :icon, :string
  end
end
