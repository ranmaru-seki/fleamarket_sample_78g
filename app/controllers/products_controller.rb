class ProductsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @product = Product.new
    @product.images.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :item_info, :brand, :status_id, :size, :delivery_id, :region_id, :day_id, :price, :category_id, :user_id, images_attributes: [:src])
  end


end