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
    @user_products_array = Product.where(user_id: @user.id)

  end

  def user_products
    @parents = Category.where(ancestry: nil)
    @user = User.find(params[:id])
    @user_products_array = Product.where(user_id: @user.id).reverse
  end

end
