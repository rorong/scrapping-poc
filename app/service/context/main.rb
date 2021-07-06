class Context::Main
  attr_accessor :product_obj

  def initialize(product_obj)
    @product_obj = product_obj
  end

  def perform
    product_obj.execute
  end
end
