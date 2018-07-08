class CreateAffiches < ActiveRecord::Migration[5.2]
  def change
    create_table :affiches do |t|
      t.string :title
      t.text :body
      t.boolean :enabled
      t.boolean :user_enabled
      t.string :place
      t.integer :price
      t.datetime :start_time
      t.belongs_to :user, foreign_key: true
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
