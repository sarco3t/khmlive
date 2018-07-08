class AddExtraToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :extra, :jsonb, null: false, default: {}
    add_index :posts, :extra, using: :gin
  end
end
