class CreateMealDrinks < ActiveRecord::Migration[7.1]
  def change
    create_table :meal_drinks do |t|
      t.references :meal, null: false, foreign_key: true
      t.references :drink, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
