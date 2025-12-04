class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :stocks, dependent: :destroy
         has_many :guests
         has_many :meals
         has_many :friends


  def all_friends
    @friends1 = Friend.where(user_main_id: self.id).map {|friend| friend.user_friend}
    @friends = Friend.where(user_friend_id: self.id).map {|friend| friend.user_main} + @friends1
  end
end
