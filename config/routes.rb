Pykhub::Application.routes.draw do
    
  devise_for :users, :controllers => {:sessions => "sessions", :registrations => "registrations", :confirmations => "confirmations"}
  
  #users
  get "/settings", to: "users#edit", as: "edit_user"
  put "/:user_id/update", to: "users#update", as: "update_user"
  get "/:user_id", to: "users#show", as: "user"
  
  #tags
  post "/:user_id/:account_id/tags/create", to: "core_tags#create", as: "create_user_account_core_tags"
  put "/:user_id/:account_id/tags/:tag_id/update", to: "core_tags#update", as: "update_user_account_core_tag"
  get "/:user_id/:account_id/tags/:tag_id/delete", to: "core_tags#destroy", as: "delete_user_account_core_tag"
  get "/:user_id/:account_id/tags/:tag_id", to: "core_tags#show", as: "user_account_core_tag"      
  
  #root
  root :to => 'static_pages#index'
  
end