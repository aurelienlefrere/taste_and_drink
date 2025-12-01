class CreateMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :meals do |t|
      t.string :dish_name
      t.references :user, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
