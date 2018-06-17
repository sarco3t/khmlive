class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :description
      t.boolean :enable, default: true
      t.datetime :deleted_at, null: true

      t.timestamps
    end
  end
end
