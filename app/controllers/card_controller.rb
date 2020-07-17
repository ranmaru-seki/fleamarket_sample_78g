class CardController < ApplicationController
  require "payjp"

  def new
    @card = Card.where(user_id: current_user.id)
    redirect_to card_path(current_user.id) if @card.exists?
  end

  def create
    Payjp.api_key = Rails.application.credentials[:payjp][:access_key]

    if params["payjp_token"].blank?
      redirect_to action: "new", alert: "クレジットカードを登録できませんでした。"
    else
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params["payjp_token"],
        metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
      else
        redirect_to action: "create"
      end
    end
  end

  def show
    # ログイン中のユーザーのクレジットカード登録の有無を判断
    @card = Card.find_by(user_id: current_user.id)
    if @card.blank?  # 未登録なら新規登録画面に
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials[:payjp][:access_key]
      # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @customer_card = customer.cards.retrieve(@card.card_id)

      ##カードのアイコン表示のための定義づけ
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

      @exp_month = @customer_card.exp_month.to_s
      @exp_year = @customer_card.exp_year.to_s.slice(2,3)
    end
  end

  def destroy
    @card = Card.find_by(user_id: current_user.id)
    if @card.blank?
      # 未登録なら新規登録画面に
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials[:payjp][:access_key]
      # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
      # 削除が完了しているか判断
      if @card.destroy
      else
        redirect_to card_path(current_user.id), alert: "削除できませんでした。"
      end
    end
  end

end
