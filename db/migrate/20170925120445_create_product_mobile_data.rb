class CreateProductMobileData < ActiveRecord::Migration[5.0]
  def change
    create_table :product_mobile_data do |t|
    	t.string :category_id
      t.string :product_title
      t.string :price
      t.string :description
      t.string :extra_bonus
      t.timestamps
    end
  end
end
