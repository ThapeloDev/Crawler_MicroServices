class ProductMobileData < ActiveRecord::Base

  has_many :product_mobile_image, dependent: :destroy
end
