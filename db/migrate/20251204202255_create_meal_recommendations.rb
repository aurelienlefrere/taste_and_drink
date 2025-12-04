class CreateMealRecommendations < ActiveRecord::Migration[7.1]
  def change
    create_table :meal_recommendations do |t|
      t.references :meal, null: false, foreign_key: true
      t.text :analysis
      t.text :wine_suggestions
      t.text :alcoholic_suggestions
      t.text :non_alcoholic_suggestions
      t.text :unusual_suggestions

      t.timestamps
    end
  end
end
