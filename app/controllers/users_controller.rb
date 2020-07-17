class UsersController < ApplicationController

  def new
  end

  def edit
    @user = User.find(params[:id])
    @parents = Category.where(ancestry: nil);
  end

  def show
    @user = User.find(params[:id])
    @parents = Category.where(ancestry: nil);
  end

end