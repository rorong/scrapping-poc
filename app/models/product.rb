class Product < ApplicationRecord
  enum product_type: { mobile: 0, men_footwear: 1, women_footwear: 2, women_sandal: 3, beauty_grooming: 4 }
  validates :url, :product_type, :price, presence: true
end
