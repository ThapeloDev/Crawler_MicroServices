class CreateProductImage < ActiveRecord::Migration[5.0]
  def change
    create_table :product_mobile_images do |t|
    	t.string :product_mobile_data_id
    	t.timestamps
    end
  end
end
