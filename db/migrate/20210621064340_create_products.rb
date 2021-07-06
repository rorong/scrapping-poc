class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :product_type
      t.string :name
      t.string :rating
      t.string :review
      t.string :url
      t.float :price
      t.string :brand
      t.string :combo
      t.timestamps
    end
  end
end
