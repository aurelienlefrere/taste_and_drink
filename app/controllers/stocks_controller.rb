class StocksController < ApplicationController
  #def index
  # @stocks = current_user.stocks.includes(:drink)
  #end

  def new
    @stock = Stock.new
  end

  def create
    @drink = Drink.find(stock_params[:drink_id])
    @stock = current_user.stocks.find_by(drink: @drink)

    if @stock
      redirect_to stocks_path, alert: "Vous l'avez déjà dans votre cave !"
    else
      @stock = current_user.stocks.new(stock_params)
      if @stock.save
        redirect_to stocks_path, notice: 'Stock ajouté avec succès'
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def show
    @stock = current_user.stock
  end

  def edit
  end

  def update
    @stock = current_user.stocks.find(params[:id])
    new_quantity = stock_params[:quantity].to_i

    if new_quantity <= 0
      @stock.destroy
      redirect_to stocks_path, notice: 'Stock supprimé'
    elsif @stock.update(quantity: new_quantity)
      redirect_to stocks_path, notice: 'Quantité mise à jour'
    else
      redirect_to stocks_path, alert: 'Erreur'
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:drink_id, :quantity)
  end
end
