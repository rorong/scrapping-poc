class Product::Mobile < Product::Base
  def initialize
    @base_catg_url = 'https://www.flipkart.com/mobiles/pr?sid=tyy,4io&otracker=categorytree'
  end

  attr_reader :base_catg_url

  # Overriding abstract method
  def product_listing
    parsed_page(base_catg_url).css('div._2kHMtA') # products
  end

  def last_page
    lp = parsed_page(base_catg_url)
         .css('div._2MImiq')
         .css('span')
         .children
         .first
         .text
         .split(' ')
         .last
         .to_i
    lp > 1 ? 1 : lp
  end

  def pagination_url(page_no)
    return base_catg_url if page_no == 1

    "https://www.flipkart.com/mobiles/pr?sid=tyy%2C4io&otracker=categorytree&page=#{page_no}"
  end

  def pagewise_product_listing(page_no)
    parsed_page(pagination_url(page_no)).css('div._2kHMtA')
  end

  def extract_products
    product_array = []
    (first_page..last_page).each do |page_no|
      pagewise_product_listing(page_no).css('div._2kHMtA').each do |product|
        product_array << build_product_hash(product)
      end
    end

    product_array
  end

  def build_product_hash(product)
    {
      product_type: 0,
      name: product.css('div._4rR01T').text,
      rating: product.css('span._2_R_DZ').text.split('&')[0],
      review: product.css('span._2_R_DZ').text.split('&')[1],
      url: "https://flipkart.com#{product.css('a')[0].attributes['href'].value}",
      price: (product.css('div._30jeq3').text.gsub('₹', '').gsub(',', '').to_f rescue 0.0)
    }
  end
end
