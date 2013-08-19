require 'test_helper'

class ProductTest < ActiveSupport::TestCase
   fixtures :products
   test "product attributes must not be empty" do
      product = Product.new
      assert product.invalid?
      assert product.errors[:title].any?
      assert product.errors[:description].any?
      assert product.errors[:price].any?
  end

   test "second test" do
      product = Product.new(title: "my book", description: "yyy", image_url: "image_url.jpg")
      product.price = -1
      assert product.invalid?
      assert_equal "must be greater than or equal to 0.01", product.errors[:price].join(';')
      product.price = 0
      assert product.invalid?
      assert_equal "must be greater than or equal to 0.01", product.errors[:price].join(';')
      product.price = 1
      assert !product.valid?
   end
 
   test "third test" do
      product = Product.new(title: products(:ruby).title, description: "descr", price: 1, image_url: "test")
      assert !product.save
      assert_equal "has already been taken", product.errors[:title].join('; ')
      
   end
   
   test "check title length" do
      product = Product.new(title: )
      assert !product.errors[:title].any?
   end

end
