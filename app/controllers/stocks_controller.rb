class StocksController < ApplicationController
  def index
    @stocks = current_user.stocks.includes(:drink)
  end

  def new
    @stock = Stock.new
  end

  def create
    @drink = Drink.find(stock_params[:drink_id])
    @stock = current_user.stocks.find_by(drink: @drink)

    if @stock
      # La bouteille existe déjà → ON ADDITIONNE LES QUANTITÉS
      nouvelle_quantite = stock_params[:quantity].to_i
      @stock.quantity += nouvelle_quantite

      if @stock.save
        redirect_to stocks_path, notice: "✅ #{nouvelle_quantite} bouteille(s) ajoutée(s) ! Total : #{@stock.quantity}"
      else
        redirect_to stocks_path, alert: "❌ Erreur lors de l'ajout"
      end
    else
      # Nouvelle bouteille → ON LA CRÉE
      @stock = current_user.stocks.new(stock_params)

      if @stock.save
        redirect_to stocks_path, notice: "✅ Bouteille ajoutée à votre cave !"
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def show
    @stock = current_user.stocks.find(params[:id])
    @drink = @stock.drink
  end

  def edit
  end

  def update
    @stock = current_user.stocks.find(params[:id])
    new_quantity = stock_params[:quantity].to_i

    if new_quantity <= 0
      @stock.destroy
      redirect_to stocks_path
    elsif @stock.update(quantity: new_quantity)
      redirect_to stocks_path
    else
      redirect_to stocks_path
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:drink_id, :quantity)
  end
end
