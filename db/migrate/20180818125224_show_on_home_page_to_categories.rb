class ShowOnHomePageToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :on_home_page, :boolean, default: false
  end
end
