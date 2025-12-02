class StocksController < ApplicationController

  def index
    @stocks = current_user.stocks
  end


  def show
    @stock = current_user.stock
  end

  def edit
  end

  def update
  end
end
