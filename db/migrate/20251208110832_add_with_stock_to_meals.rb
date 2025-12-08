class AddWithStockToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :with_stock, :boolean
  end
end
