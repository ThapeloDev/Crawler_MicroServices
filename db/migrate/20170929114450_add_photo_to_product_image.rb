class AddPhotoToProductImage < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :product_mobile_images, :photo
  end
end
