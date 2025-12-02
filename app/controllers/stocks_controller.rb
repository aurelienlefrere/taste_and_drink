class StocksController < ApplicationController

  def new
    @stock = Stock.new
  end

  
  def show
    @stock = current_user.stock
  end

  def edit
  end

  def update
  end
end
