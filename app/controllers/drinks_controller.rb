class DrinksController < ApplicationController

  def show
    @drink = Drink.find(params[:id])
  end

end
