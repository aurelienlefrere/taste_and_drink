class Drink < ApplicationRecord
  has_many :stocks
  has_many :meal_drinks
  has_neighbors :embedding
  after_create :set_embedding

  private

  def set_embedding
    embedding = RubyLLM.embed("Bottle title: #{title}. Category: #{category}. Region: #{region}. Year: #{year}")
    update(embedding: embedding.vectors)
  end
end
