class ProductsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @product = Product.new
    @product.images.new
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def get_category_children
    respond_to do |format| 
      format.html
      format.json do
        @children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
      end
    end
  end
  
  def get_category_grandchildren
    respond_to do |format| 
      format.html
      format.json do
        @grandchildren = Category.find("#{params[:child_id]}").children
      end
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :item_info, :brand, :status_id, :size, :delivery_id, :region_id, :day_id, :price, :category_id, images_attributes: [:src]).merge(user_id: current_user.id)
  end


end