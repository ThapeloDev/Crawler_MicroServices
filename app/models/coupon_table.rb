class CouponTable < ActiveRecord::Base
  include Mongoid::Document
  field :title, type: String
  field :page, type: String
  field :percent_discount, type: String

end
