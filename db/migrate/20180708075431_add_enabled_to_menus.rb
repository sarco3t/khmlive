class AddEnabledToMenus < ActiveRecord::Migration[5.2]
  def change
    add_column :menus, :enabled, :boolean, default: false
  end
end
