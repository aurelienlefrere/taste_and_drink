class CreateDrinks < ActiveRecord::Migration[7.1]
  def change
    create_table :drinks do |t|
      t.string :title
      t.string :category
      t.string :region
      t.integer :year
      t.text :photo

      t.timestamps
    end
  end
end
