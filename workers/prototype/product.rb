class Product
  attr_accessor :product_definition_name,
                :properties,
                :active,
                :category

  def _clone(product_definition)
    clone_product = Product.new
    clone_product.product_definition_name = product_definition

    clone_product
  end

  def main
    product_prototype = Product.new
    product_instance_a = product_prototype._clone("Telescope")
    product_instance_b = product_prototype._clone("Light Saber")
    binding.pry
  end
end


