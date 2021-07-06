class Product::BeautyGrooming < Product::Base
  def initialize
    @base_catg_url = 'https://www.flipkart.com/beauty-and-grooming/pr?sid=g9b&p[]=facets.serviceability%5B%5D%3Dtrue&otracker=categorytree&otracker=nmenu_sub_Women_0_Beauty%20%26%20Grooming'
  end

  attr_reader :base_catg_url

  # Overriding abstract method
  def product_listing
    parsed_page(base_catg_url).css('div._13oc-S') # products
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

    "https://www.flipkart.com/beauty-and-grooming/pr?sid=g9b&p%5B%5D=facets.serviceability%5B%5D%3Dtrue&otracker=categorytree&otracker=nmenu_sub_Women_0_Beauty+%26+Grooming&page=#{page_no}"
  end

  def pagewise_product_listing(page_no)
    parsed_page(pagination_url(page_no)).css('div._13oc-S')
  end

  def extract_products
    product_array = []
    (first_page..last_page).each do |page_no|
      pagewise_product_listing(page_no).css('div._13oc-S').each do |product_listing|
        product_listing.css('div._4ddWXP').each do |product|
          product_array << build_product_hash(product)
        end
      end
    end

    product_array
  end

  def build_product_hash(product)
    {
      product_type: 4,
      brand: product.css('a')[1].text,
      url: "https://flipkart.com#{product.css('a')[0].attributes['href'].value}",
      price: (product.css('div._30jeq3').text.gsub('₹', '').gsub(',', '').to_f rescue 0.0)
    }
  end
end
