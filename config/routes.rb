XingCmsBackend::Engine.routes.draw do

  get "pages/:url_slug", :to => 'pages#show', :as => :page

  #resources :menus, :only => [:show, :index, :update]
  #TODO: Enable when show and update are needed
  resources :menus, :only => [:index]

  namespace :admin do
    resources :menu_items
    resources :pages, :param => :url_slug
    resources :content_blocks
  end
end
