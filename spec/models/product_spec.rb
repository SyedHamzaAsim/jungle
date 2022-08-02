require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid" do
      @product = Product.new
      @newCategory = Category.new
      @newCategory.name = 'TestCategory'
      @product.name = 'Test'
      @product.price = 123
      @product.quantity = 45
      @product.category = @newCategory
      expect(@product.valid?).to be true
    end

    it "Looks for name", type: :model do
      @product = Product.new
      @product.name = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "looks for price" do
      @product = Product.new
      @product.valid?
      @product.price = nil
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "looks for quantity" do
      @product = Product.new
      @product.quantity = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "looks for category" do
      @cat = Category.new
      @product = Product.new
      @product.category = nil # invalid state
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end