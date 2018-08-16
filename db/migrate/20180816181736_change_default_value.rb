class ChangeDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:posts, :enabled, true)
  end
end
