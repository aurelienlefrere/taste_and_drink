class Meal < ApplicationRecord
  belongs_to :user
  has_many :guests
  has_many :meal_drinks
  has_many :drinks, through: :meal_drinks


end
