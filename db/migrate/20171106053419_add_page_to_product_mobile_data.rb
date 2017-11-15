class AddPageToProductMobileData < ActiveRecord::Migration[5.0]
  def change
  	add_column :product_mobile_data, :page_source, :string
  end
end
