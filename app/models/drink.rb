class Drink < ApplicationRecord
  has_many :cellars
  has_many :meal_drinks
end
