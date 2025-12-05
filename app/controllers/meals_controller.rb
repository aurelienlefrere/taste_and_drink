class MealsController < ApplicationController

  def index
    @meals = Meal.all
  end

  def show
    @meal = Meal.find(:id)
  end

  def new
    @meal = Meal.new
    @friends = current_user.all_friends
    # @stock = current_user.stock
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user
    if @meal.save
      @guest_ids = guest_params[:guest_ids].compact_blank
      @guest_ids.each do |guest|
        Guest.create(user_id: guest.to_i, meal: @meal)
      end



    with_stock = params[:with_stock] == 'true'
    # faire methode pour générer guest. user avec le contenu interessant
    chat_params = [dish_name, guest_ids]


    if with_stock
      drinks = current_user.drinks.where('stock > 0')
      chat_params << drinks
    end

    @chat = Chat.find(*chat_params)
     embedding = RubyLLM.embed(params[])
     # params []  drinks, dislike, like, dish_name
    render json: @chat




    redirect_to root_path
    else
    render :new, status: :unprocessable_entity
    end
  end



private
  def meal_params
    params.require(:meal).permit(:dish_name)
  end
  def guest_params
    params.require(:meal).permit(guest_ids: [])
  end
end
