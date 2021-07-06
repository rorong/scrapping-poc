class ProductController < ApplicationController
  def index
    @product_categories = Product.product_types
  end

  def product_list
    @product_lists = Scrape::Main.new(params[:key]).list.paginate(page: params[:page], per_page: 10)
    flash[:error] = 'No products found!!!' unless @product_lists.present?
  end

  def product_crawl
    @product_lists = Scrape::Main.new(params[:key]).crawl
    flash[:success] = 'Product successfully crawled!!!' if @product_lists.present?
    redirect_to root_path
  end
end
