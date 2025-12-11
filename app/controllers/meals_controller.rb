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

    @drinks_wine = @meal.drinks.where(category: "Vin").excluding(@drinks_stocks).uniq.first(3)
    # @wines = @meal.meal_drinks.where(drink: @drinks_wine)

    @my_cellar = @meal.meal_drinks.where(drink: @drinks_stocks).map(&:drink).uniq.first(3)

    @drinks_alcohol = @meal.drinks.where(category: "Alcoolisée").uniq.first(3)
    # @alcohol = @meal.meal_drinks.where(drink: @drinks_alcohol)

    @drinks_no_alcohol = @meal.drinks.where(category: "Non alcoolisée").uniq.first(3)
    # @no_alcohol = @meal.meal_drinks.where(drink: @drinks_no_alcohol)

    @drinks_impro = @meal.drinks.where(category: "Improbable").uniq.first(3)
    # @improbable = @meal.meal_drinks.where(drink: @drinks_impro)
  end

  def new
    @meal = Meal.new
    @friends = current_user.all_friends
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user
    @meal.date = Date.today

    if @meal.save
      # Créer les invités
      @guest_ids = Array(guest_params[:guest_ids]).compact_blank
      @guest_ids.each do |guest|
        Guest.create(user_id: guest.to_i, meal: @meal)
      end

      @meal.update(with_stock: params[:with_stock] == 'true')

      # Générer les recommandations IA
      prompt = chat_prompt(@meal)
      embedding = RubyLLM.embed(prompt)

      # Ma cave - SEULEMENT si "Utiliser ma cave" est coché
      if params[:with_stock] == 'true'
        @drinks_stocks = current_user.drinks.nearest_neighbors(:embedding, embedding.vectors, distance: "euclidean").first(3)
        @drinks_stocks.each do |drink|
          MealDrink.create(meal: @meal, drink: drink, status: "recommendation")
        end
      end

      # Vin
      @drinks_wine = Drink.where(category: "Vin").excluding(current_user.drinks).nearest_neighbors(:embedding, embedding.vectors, distance: "euclidean").first(3)
      @drinks_wine.each do |drink|
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
      @friends = current_user.all_friends
      render :new, status: :unprocessable_entity
    end
  end

  # AJOUTEZ CETTE MÉTHODE si elle n'existe pas
  def create_event
    @meal = Meal.find(params[:id])

    # Récupérer les meal_drinks sélectionnés
    meal_drink_ids = params[:selected_meal_drink_ids] || []

    if meal_drink_ids.empty?
      flash[:alert] = "⚠️ Veuillez sélectionner au moins une boisson"
      redirect_to meal_path(@meal) and return
    end

    # Changer le status de "recommendation" à "validated"
    meal_drink_ids.each do |drink_id|
      meal_drink = @meal.meal_drinks.find_by(drink_id: drink_id)
      meal_drink.update(status: "validated")
    end

    flash[:success] = "🎉 Événement sauvegardé avec #{meal_drink_ids.count} boisson(s) !"
    redirect_to meals_path
  end

  def destroy
    @meal = Meal.find(params[:id])

    # Vérifier que c'est bien l'utilisateur propriétaire
    if @meal.user == current_user
      @meal.destroy
      flash[:success] = "Événement supprimé avec succès"
    else
      flash[:alert] = "Vous ne pouvez pas supprimer cet événement"
    end

    redirect_to meals_path
  end

  private

  def meal_params
    params.require(:meal).permit(:dish_name, :photo)
  end

  def guest_params
    params.require(:meal).permit(guest_ids: [])
  end

  def chat_prompt(meal)
    chat_params = []
    chat_params << meal.dish_name
    return "" if meal.guests.empty?

    meal.guests.map(&:user).each do |user|
      details = []
      details << "Régime: #{user.diet}" if user.diet.present?
      details << "Allergies: #{user.allergy}" if user.allergy.present?
      details << "Aime: #{user.like}" if user.like.present?
      details << "N'aime pas: #{user.dislike}" if user.dislike.present?
      details << "\n"
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
        details << "\n"
        chat_params += details
      end
    end

    chat_params.join
  end

end  # FIN de la classe - IMPORTANT !
