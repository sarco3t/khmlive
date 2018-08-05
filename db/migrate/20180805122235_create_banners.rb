class CreateBanners < ActiveRecord::Migration[5.2]
  def change
    create_table :banners do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :link, null: false
      t.integer :banner_position, default: 0
      t.integer :views, default: 0, null: false
      t.timestamps
    end
  end
end
