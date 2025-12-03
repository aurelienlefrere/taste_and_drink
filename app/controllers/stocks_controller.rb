class StocksController < ApplicationController

  def new
    @stock = Stock.new
  end

def create
    @stock = Stock.new(stock_params)
    @stock.user = current_user
    if @stock.save
      redirect_to stock_users_path
    else
      render "new", status: :unprocessable_entity
    end
  end

  def show
    @stock = current_user.stock
  end

  def edit
  end

  def update
    
  end

  private

  def stock_params
    params.require(:stock).permit(:drink_id, :quantity)
  end
end
