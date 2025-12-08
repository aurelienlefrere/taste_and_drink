class Meal < ApplicationRecord
  belongs_to :user
  has_many :guests
  has_many :meal_drinks



end
