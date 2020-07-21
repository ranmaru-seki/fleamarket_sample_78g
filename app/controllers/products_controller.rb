class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :show_sold, :edit, :update, :destroy]
  before_action :category_array_for_new, only: [:new, :create]
  before_action :category_array_for_edit, only: [:edit, :update]
  before_action :category_array_for_edit, only: [:edit, :update]
  before_action :move_to_index, only: [:new, :edit, :update, :create, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy]


  def index
    @parents = Category.where(ancestry: nil)
    @product_array = Product.all.reverse
    @lady_product_array = @product_array.select { |product| product.category.root.id == 1 }
  end

  def show
    if @product.purchase_id == nil
      @parents = Category.where(ancestry: nil)
      @image = Image.find_by(product_id: @product.id)
      @image_array = Image.where(product_id: @product.id)
      @product_array = Product.where(category_id: @product.category_id).reverse
    else
      redirect_to show_sold_product_path(@product.id)
    end
  end

  def show_sold
    unless @product.purchase_id == nil
      @parents = Category.where(ancestry: nil)
      @image = Image.find_by(product_id: @product.id)
      @image_array = Image.where(product_id: @product.id)
      @product_array = Product.where(category_id: @product.category_id).reverse
    else
      redirect_to product_path(@product.id)
    end
  end

  def new
    @product = Product.new
    @product.images.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = '商品出品が完了しました'
      redirect_to product_path(@product.id)
    else
      flash[:alert] = '必須項目を入力してください'
      redirect_to action: "new"
    end
  end

  def edit
    Image.where(product_id: @product.id)
  end

  def update
    if @product.update(product_params)
      flash[:notice] = '商品情報を更新しました'
      redirect_to product_path(@product.id)
    else
      flash.now[:alert] = '必須項目を入力してください'
      render :edit
    end
  end

  def destroy
    @product.destroy
    flash[:alert] = '商品を削除しました'
    redirect_to root_path
  end

  def search
    @parents = Category.where(ancestry: nil);
    @products = Product.search(params[:keyword])
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

  def set_product
    @product = Product.find(params[:id])
  end

  def category_array_for_new
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def category_array_for_edit
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

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
      flash[:alert] = "ログインして下さい"
    end
  end

  def authenticate_user
    if current_user.id != @product.user.id
      redirect_to action: :index
    end
  end
end
