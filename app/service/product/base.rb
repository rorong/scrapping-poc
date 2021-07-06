class Product::Base
  def initialize(); end

  def execute
    import_product(extract_products)
  end

  def parsed_page(url)
    Nokogiri::HTML(HTTParty.get(url))
  end

  def import_product(products)
    products = products.map do |attrs|
      Product.new(attrs)
    end
    Product.import products
  end

  def build_product_hash(product)
    raise 'Abstract method not implemented error!!!'
  end

  def extract_products
    raise 'Abstract method not implemented error!!!'
  end

  def first_page
    1
  end

  def last_page
    raise 'Abstract method not implemented error!!!'
  end

  def product_listing
    raise 'Abstract method not implemented error!!!'
  end

  def pagination_url(page_no)
    raise 'Abstract method not implemented error!!!'
  end

  def pagewise_product_listing(page_no)
    raise 'Abstract method not implemented error!!!'
  end
end
