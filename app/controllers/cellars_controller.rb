class CellarsController < ApplicationController
  def show
    @cellar = current_user.cellar
  end

  def edit
  end

  def update
  end
end
