class UsersController < ApplicationController
before_action :set_user, only: :show
  def index
    @users = User.all
  end

  def show
    @friends1 = Friend.where(user_main_id: @user.id).map {|friend| friend.user_friend}
    @friends = Friend.where(user_friend_id: @user.id).map {|friend| friend.user_main} + @friends1 

  end

  def friends
  @friends = Friend.all
  end


private
  def set_user
    @user = User.find(params[:id])
  end

  def stock
    @stocks = current_user.stocks
  end
end
