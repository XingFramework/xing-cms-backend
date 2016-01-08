XingCmsBackend::Engine.routes.draw do

  namespace :admin do
    resources :menu_items
  end
end
