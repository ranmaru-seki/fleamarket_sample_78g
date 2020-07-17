class OrdersController < ApplicationController

  def new
  end

  def create
  end

  require "payjp"

  def buy
    @product = Product.find(params[:product_id])
    @image = Image.find_by(product_id: @product.id)
  
    if user_signed_in?
      @user = current_user
      @address = Address.find_by(user_id: current_user.id)
      if @user.card.present?
        Payjp.api_key = Rails.application.credentials[:payjp][:access_key]
        @card = Card.find_by(user_id: current_user.id)
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @customer_card = customer.cards.retrieve(@card.card_id)
        @card_brand = @customer_card.brand
        case @card_brand
        when "Visa"
          @card_src = "card.images/visa.gif"
        when "JCB"
          @card_src = "card.images/jcb.gif"
        when "MasterCard"
          @card_src = "card.images/master.gif"
        when "American Express"
          @card_src = "card.images/amex.gif"
        when "Diners Club"
          @card_src = "card.images/diners.gif"
        end
        # viewの記述を簡略化
        ## 有効期限'月'を定義
        @exp_month = @customer_card.exp_month.to_s
        ## 有効期限'年'を定義
        @exp_year = @customer_card.exp_year.to_s.slice(2,3)
      else
      end
    else
      # ログインしていなければ、商品の購入ができずに、ログイン画面に移動します。
      redirect_to user_session_path, alert: "ログインしてください"
    end
  end

  def pay
    @product = Product.find(params[:product_id])
    @images = @product.images.all

    if current_user.card.present?
      # ログインユーザーがクレジットカード登録済みの場合の処理
      # ログインユーザーのクレジットカード情報を引っ張ってきます。
      @card = Card.find_by(user_id: current_user.id)
      # 前前前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
      Payjp.api_key = Rails.application.credentials[:payjp][:access_key]
      #登録したカードでの、クレジットカード決済処理
      charge = Payjp::Charge.create(
      # 商品(product)の値段を引っ張ってきて決済金額(amount)に入れる
      amount: @product.price,
      customer: Payjp::Customer.retrieve(@card.customer_id),
      currency: 'jpy'
      )
    else
      # ログインユーザーがクレジットカード登録されていない場合(Checkout機能による処理を行います)
      # APIの「Checkout」ライブラリによる決済処理の記述
      Payjp::Charge.create(
      amount: @product.price,
      card: params['payjp-token'],
      currency: 'jpy'
      )
    end
    order = Order.create(user_id: current_user.id, product_id: params[:product_id])
    order.product.update(purchase_id: current_user.id)
  end

end
