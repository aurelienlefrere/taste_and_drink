class MealrecommendationsController < ApplicationController

  def new
  @meal_recommendations = MealRecommendation.new
  end







  drinks = Drink.nearest_neighbors(:embedding, embedding.vectors, distance: "euclidean").first(2)
  instructions = system_prompt
  instructions += drinks.map { |drink| drink_prompt(drink) }.join("\n\n")
  if @chat.with_instructions(instructions).ask(params[:title][:category])
    redirect_to chat_path(@chat)
  else
    @message = @chat.messages.last
    render "chats/show", status: :unprocessable_entity
  end
end
