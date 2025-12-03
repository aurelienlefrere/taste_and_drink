class MealsController < ApplicationController

  def index
    @meals = Meal.all
  end

  def show
    @meal = Meal.find(:id)
  end

  def new
    @meal = Meal.new
    # @stock = current_user.stock
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user
    if @meal.save
    redirect_to root_path
    else
    render :new, status: :unprocessable_entity
    end
  end

private
  def meal_params
    params.require(:meal).permit(:dish_name)
  end
end
