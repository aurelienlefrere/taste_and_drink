class UsersController < ApplicationController

  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
  end

  def stock
    @stocks = current_user.stocks
  end
end
