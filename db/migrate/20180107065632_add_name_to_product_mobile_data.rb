class AddNameToProductMobileData < ActiveRecord::Migration[5.0]
  def change
    add_column :product_mobile_data, :full_name, :string
  end
end
