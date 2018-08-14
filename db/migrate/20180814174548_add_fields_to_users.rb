class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :extra, :json, default: {}
  end
end
