class CreateCouponTable < ActiveRecord::Migration[5.0]
  def change
    create_table :coupon_tables do |t|
      t.string :title
      t.string :page
      t.string :percent_discount
    end
  end
end
