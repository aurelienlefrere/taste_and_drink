class MealRecommendation < ApplicationRecord
  belongs_to :meal

    # private

  # def set_embedding
  #   embedding = RubyLLM.embed("Drink: #{title}. Category: #{category}")
  #   update(embedding: embedding.vectors)
  # end
end
