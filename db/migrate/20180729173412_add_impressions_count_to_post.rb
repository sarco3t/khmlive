class AddImpressionsCountToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :views_count, :int, default: 0
  end
end
