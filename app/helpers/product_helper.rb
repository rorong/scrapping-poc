module ProductHelper
  def find_product_list(key)
    case key
    when 'mobile'
      'Mobile'
    when 'men_footwear'
      'Men Footwear'
    when 'women_footwear'
      'Women Footwear'
    when 'women_sandal'
      'Women Sandal'
    when 'women_shoe'
      'Women Shoe'
    when 'beauty_grooming'
      'Beauty Grooming'
    end
  end

  def product_exists?(key)
    Scrape::Main.new(key).list.present?
  end
end
