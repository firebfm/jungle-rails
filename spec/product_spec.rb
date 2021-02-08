require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save with a valid category, name, price and quantity' do
      @category = Category.create(name: "Snacks")
      product = Product.new(name: "Herbal Jelly", price: 2.50, quantity: 8, category: @category)
      expect(product).to (be_valid)
    end

    it 'should not save with no name' do
      @category = Category.create(name: "Snacks")
      product = Product.new(name: nil, price: 2.50, quantity: 8, category: @category)
      expect(product).to_not (be_valid)
    end

    it 'should not save with no price' do
      @category = Category.create(name: "Snacks")
      product = Product.new(name: "Herbal Jelly", price: nil, quantity: 8, category: @category)
      expect(product).to_not (be_valid)
    end

    it 'should not save with no quanitity' do
      @category = Category.create(name: "Snacks")
      product = Product.new(name: "Herbal Jelly", price: 2.50, quantity: nil, category: @category)
      expect(product).to_not (be_valid)
    end
  end
end