class AddImageLinkToProductMobileImage < ActiveRecord::Migration[5.0]
  def change
    add_column :product_mobile_data, :image_link, :string
  end
end
