class Stock < ApplicationRecord
  belongs_to :user
  belongs_to :drink

  validates :drink_id, uniqueness: { scope: :user_id }
  validates :quantity, presence: true
end
