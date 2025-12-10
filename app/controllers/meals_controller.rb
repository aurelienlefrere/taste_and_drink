class MealsController < ApplicationController

  def index
    @meals = current_user.meals
                         .includes(:guests, :meal_drinks, :drinks)
                         .order(created_at: :desc)
  end

  def show
    @meal = Meal.find(params[:id])
    @drinks = @meal.drinks
    @drinks_stocks = current_user.drinks

    @drinks_wine = Drink.where(category: "Wine").excluding(@drinks_stocks)
    @wines = @meal.meal_drinks.where(drink: @drinks_wine)

    @my_cellar = @meal.meal_drinks.where(drink: @drinks_stocks)

    @drinks_alcohol = Drink.where(category: "Alcoolisée")
    @alcohol = @meal.meal_drinks.where(drink: @drinks_alcohol)

    @drinks_no_alcohol = Drink.where(category: "Non alcoolisée")
    @no_alcohol = @meal.meal_drinks.where(drink: @drinks_no_alcohol)

    @drinks_impro = Drink.where(category: "Improbable")
    @improbable = @meal.meal_drinks.where(drink: @drinks_impro)
  end

  def new
    @meal = Meal.new
    @friends = current_user.all_friends
    # @stock = current_user.stock
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user
    @meal.date = Date.today
    if @meal.save
      @guest_ids = Array(guest_params[:guest_ids]).compact_blank
      @guest_ids.each do |guest|
        Guest.create(user_id: guest.to_i, meal: @meal)
      end
      @meal.update(with_stock: params[:with_stock] == 'true')
      prompt = chat_prompt(@meal)
      embedding = RubyLLM.embed(prompt)

      # Vin
      @drinks_wine = Drink.where(category: "Wine").excluding(current_user.drinks).nearest_neighbors(:embedding, embedding.vectors, distance: "euclidean").first(3)
      @drinks_wine.each do |drink|
        MealDrink.create(meal: @meal, drink: drink, status: "recommendation")
      end

    # Ma cave
      @drinks_stocks = current_user.drinks.nearest_neighbors(:embedding, embedding.vectors, distance: "euclidean").first(3)
      @drinks_stocks.each do |drink|
        MealDrink.create(meal: @meal, drink: drink, status: "recommendation")
      end
      # Drink alcohol
      @drinks_alcohol = Drink.where(category: "Alcoolisée").nearest_neighbors(:embedding, embedding.vectors, distance: "euclidean").first(3)
      @drinks_alcohol.each do |drink|
      MealDrink.create(meal: @meal, drink: drink, status: "recommendation")
      end

    # Drink no-alcohol
      @drinks_no_alcohol = Drink.where(category: "Non alcoolisée").nearest_neighbors(:embedding, embedding.vectors, distance: "euclidean").first(3)
      @drinks_no_alcohol.each do |drink|
        MealDrink.create(meal: @meal, drink: drink, status: "recommendation")
      end

       # Drink improbable
      @drinks_impro = Drink.where(category: "Improbable").nearest_neighbors(:embedding, embedding.vectors, distance: "euclidean").first(3)
      @drinks_impro.each do |drink|
        MealDrink.create(meal: @meal, drink: drink, status: "recommendation")
      end


      redirect_to meal_path(@meal)
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

  def chat_prompt(meal)
    chat_params= []
    chat_params << meal.dish_name
    return "" if meal.guests.empty?
    meal.guests.map(&:user).each do |user|
      details = []
      details << "Régime: #{user.diet}" if user.diet.present?
      details << "Allergies: #{user.allergy}" if user.allergy.present?
      details << "Aime: #{user.like}" if user.like.present?
      details << "N'aime pas: #{user.dislike}" if user.dislike.present?
      details <<  "\n"
      chat_params += details
    end

    if meal.with_stock

      drinks = meal.user.drinks
      drinks.each do |drink|
        details = []
        details << "Titre: #{drink.title}" if drink.title.present?
        details << "Categorie: #{drink.category}" if drink.category.present?
        details << "Région: #{drink.region}" if drink.region.present?
        details << "Année: #{drink.year}" if drink.year.present?
        details <<  "\n"
        chat_params += details
      end
    end

    chat_params.join
  end



end
