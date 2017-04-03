require 'rails_helper'

RSpec.describe Product, type: :model do

 def valid_attributes(new_attributes)
    attributes= {
      title: "Laptop",
      description: "Cool Computer",
      price: 100
    }

    attributes.merge(new_attributes)
 end


describe "validations" do
 context "title" do
   it 'requires a title' do
   product = Product.new(valid_attributes({title: nil}))
   expect(product).to be_invalid
 end

   it 'requires unique titles' do
   p1 = Product.new(valid_attributes(title: 'abc'))
   p2 = Product.new({title: 'abc'})
   p1.save
   expect(p2).to be_invalid


   end
   it 'capitalizes the title after getting saved' do
   p1 = Product.new(valid_attributes(title: 'abc'))
   p1.save
   expect(p1.title).to eq('Abc')
   end
 end

   context "description" do
      it "requires a description" do
        product = Product.new(valid_attributes({ description: nil }))
        expect(product).to be_invalid
      end
   end

   context "price" do
    it "requires a price" do
      product = Product.new(valid_attributes({price: nil}))
      expect(product).to be_invalid
   end



   it "requires the price to be greater than 0" do
     product = Product.new(valid_attributes({price: -1}))
     product.save
     expect(product.errors.messages).to have_key(:price)
    end
   end
  end
end
