class AddRatingToStocks < ActiveRecord::Migration[7.1]
  def change
    add_column :stocks, :rating, :integer
  end
end
