require 'rails_helper'

describe Product do

  describe '#create' do
    it "is invalid without a name" do
      product = build(:product, name: "")
      product.valid?
      expect(product.errors[:name]).to include("can't be blank")
    end

    it "is invalid if name has more than 40 characters " do
      product = build(:product, name: "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもらりるれろや")
      product.valid?
      expect(product.errors[:name]).to include("is too long (maximum is 40 characters)")
    end

    it "is valid if name has under 40 characters " do
      product = build(:product, name: "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもらりるれろ")
      expect(product).to be_valid
    end

    it "is invalid without a item_info" do
      product = build(:product, item_info: "")
      product.valid?
      expect(product.errors[:item_info]).to include("can't be blank")
    end

    it "is invalid without a price" do
      product = build(:product, price: "")
      product.valid?
      expect(product.errors[:price]).to include("can't be blank")
    end

    it "is valid without a brand" do
      product = build(:product, brand: "")
      expect(product).to be_valid
    end
    
    it "is valid without a size" do
      product = build(:product, size: "")
      expect(product).to be_valid
    end

  end
end