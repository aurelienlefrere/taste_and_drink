class Drink < ApplicationRecord
  has_many :stocks
  has_many :meal_drinks
end
