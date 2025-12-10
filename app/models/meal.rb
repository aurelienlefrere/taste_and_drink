class Meal < ApplicationRecord
  belongs_to :user
  has_many :guests
  has_many :meal_drinks
  has_many :drinks, through: :meal_drinks
  has_one_attached :photo

  validate :acceptable_photo, if: -> { photo.attached? }

  private

  def acceptable_photo
    return unless photo.attached?

    # Vérifier le type de fichier
    unless photo.content_type.in?(%w[image/jpeg image/png image/gif image/webp])
      errors.add(:photo, "doit être une image (JPEG, PNG, GIF ou WebP)")
    end

    # Vérifier la taille (max 5 Mo)
    if photo.byte_size > 5.megabytes
      errors.add(:photo, "est trop volumineuse (maximum 5 Mo)")
    end
  end

end
