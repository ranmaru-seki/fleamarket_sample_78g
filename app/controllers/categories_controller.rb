class CategoriesController < ApplicationController

  def show
    products = Product.all.reverse
    @parents = Category.where(ancestry: nil);
    @category = Category.find(params[:id])
    if @category.ancestry == nil
      @category_product_array = products.select { |product| product.category.root.id == @category.id }
    elsif @category.ancestry.include?("/")
      @category_product_array = products.select { |product| product.category_id == @category.id }
    else
      @category_product_array = products.select { |product| product.category.parent.id == @category.id }
    end
  end
end
