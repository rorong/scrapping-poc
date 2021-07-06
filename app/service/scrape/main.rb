class Scrape::Main
  def initialize(product_code)
    @product_code = product_code
  end

  attr_reader :product_code

  def list
    Product.where(product_type: product_code)
  end

  def crawl
    productContext.perform
  end

  def productContext
    pC =
      case product_code
      when 'mobile'
        Context::Main.new(Product::Mobile.new)
      when 'men_footwear'
        Context::Main.new(Product::MenFootwear.new)
      when 'women_footwear'
        Context::Main.new(Product::WomenFootwear.new)
      when 'women_sandal'
        Context::Main.new(Product::WomenSandal.new)
      when 'beauty_grooming'
        Context::Main.new(Product::BeautyGrooming.new)
      else
        raise 'Invalid product code !!!'
      end
    return pC
  end
end
