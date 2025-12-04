class UsersController < ApplicationController
before_action :set_user, only: :show
  def index
    @users = User.all
  end

  def show
    @friends = @user.all_friends
  end

  def friends
  @friends = Friend.all
  end

  # def stock
  #   @stocks = current_user.stocks
  # end

private
  def set_user
    @user = User.find(params[:id])
  end

end
