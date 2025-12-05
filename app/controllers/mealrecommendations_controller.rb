class MealrecommendationsController < ApplicationController

  def new
  @meal_recommendations = Meal_recommendations.new
  end

  # def create
  # end
end
