class ProductDecorator < Draper::Decorator
  delegate_all

  def price
    "$%.2f" % object.price
  end
end