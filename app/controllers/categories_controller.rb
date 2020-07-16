class CategoriesController < ApplicationController

  def show
    @parents = Category.where(ancestry: nil);
    @category = Category.find(params[:id])
  end

end
