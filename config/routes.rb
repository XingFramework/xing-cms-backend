XingCmsBackend::Engine.routes.draw do

  get "pages/:url_slug", :to => 'pages#show', :as => :page

  namespace :admin do
    resources :menu_items
    resources :pages, :param => :url_slug
    resources :content_blocks
  end
end
