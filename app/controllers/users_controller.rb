class UsersController < ApplicationController
before_action :set_user, only: :show
  def index
    @users = User.all
  end

  def show
    @friends = Friend.where(user_main_id: @user.id)
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
