class ProductsController < ApplicationController

  def index
    @parents = Category.where(ancestry: nil);
    @product_array = Product.all.reverse
    @lady_product_array = @product_array.select { |product| product.category.root.id == 1 }
  end

  def show
    @parents = Category.where(ancestry: nil);
    @product = Product.find(params[:id])
    @image = Image.find_by(product_id: @product.id)
    @image_array = Image.where(product_id: @product.id)
    @product_array = Product.where(category_id: @product.category_id).reverse
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
      redirect_to product_path(@product.id)
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    Image.where(product_id: @product.id)
    grandchild_category = @product.category
    child_category = grandchild_category.parent

    @category_parent_array = ["#{@product.category.root.name}"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
    @category_child_array = [name: "---", id: ""]
    Category.where(ancestry: child_category.ancestry).each do |children|
      @category_child_array << children
    end
    @category_grandchild_array = [name: "---", id: ""]
    Category.where(ancestry: grandchild_category.ancestry).each do |grandchildren|
      @category_grandchild_array << grandchildren
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to root_path
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

  def get_toppage_children
    @children = Category.find(params[:parent_id]).children
    respond_to do |format|
      format.html
      format.json
    end
  end

  def get_toppage_grandchildren
    @grandchildren = Category.find(params[:parent_id]).children
    respond_to do |format|
      format.html
      format.json
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :item_info, :brand, :status_id, :size, :delivery_id, :region_id, :day_id, :price, :category_id, images_attributes: [:src, :_destroy, :id]).merge(user_id: current_user.id)
  end


end
