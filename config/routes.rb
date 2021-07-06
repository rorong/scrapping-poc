Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'product#index'
  get '/products' => 'product#product_list'
  get '/crawls' => 'product#product_crawl'
end
