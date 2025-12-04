class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    friends_as_main = Friend.where(user_main_id: current_user.id).map(&:user_friend)
    friends_as_friend = Friend.where(user_friend_id: current_user.id).map(&:user_main)
    @friends = friends_as_main + friends_as_friend
  end
end
