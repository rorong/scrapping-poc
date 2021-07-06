require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validation tests" do
    context "ensure product url presence" do
      let!(:product) { Product.new(product_type: 0, price: 100).save }
      it "passes" do
        expect(product).to eq(false)
      end
    end

    context "ensure product type presence" do
      let!(:product) { Product.new(price: 100, url: 'https://flipkart.com').save }
      it "passes" do
        expect(product).to eq(false)
      end
    end

    context "ensure product price presence" do
      let!(:product) { Product.new(product_type: 0, url: 'https://flipkart.com').save }
      it "passes" do
        expect(product).to eq(false)
      end
    end

    context "ensure product successfully created!!!" do
      let!(:product) { Product.new(product_type: 0, url: 'https://flipkart.com', price: 100).save }
      it "passes" do
        expect(product).to eq(true)
      end
    end
  end
end
