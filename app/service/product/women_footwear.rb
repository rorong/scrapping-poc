class Product::WomenFootwear < Product::Base
  def initialize
    @base_catg_url = 'https://www.flipkart.com/womens-footwear/pr?sid=osp,iko&otracker=nmenu_sub_Women_0_Footwear'
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

    "https://www.flipkart.com/womens-footwear/pr?sid=osp%2Ciko&otracker=nmenu_sub_Women_0_Footwear&page=#{page_no}"
  end

  def pagewise_product_listing(page_no)
    parsed_page(pagination_url(page_no)).css('div._13oc-S')
  end

  def extract_products
    product_array = []
    (first_page..last_page).each do |page_no|
      pagewise_product_listing(page_no).css('div._13oc-S').each do |product_listing|
        product_listing.css('div._2B099V').each do |product|
          product_array << build_product_hash(product)
        end
      end
    end

    product_array
  end

  def build_product_hash(product)
    {
      product_type: 2,
      brand: product.css('div._2WkVRV').text,
      combo: product.css('a')[1].text,
      url: "https://flipkart.com#{product.css('a')[0].attributes['href'].value}",
      price: (product.css('div._30jeq3').text.gsub('₹', '').gsub(',', '').to_f rescue 0.0)
    }
  end
end
