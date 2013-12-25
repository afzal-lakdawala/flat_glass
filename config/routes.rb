Pykhub::Application.routes.draw do
  
  #oauth2callback
  match '/auth/google_oauth2/callback' => 'api_oauths#create'
  match '/auth/google_oauth2/revalidate' => 'api_oauths#revalidate'

  #get "raw/index"
  #post "raw/upload"
  
  devise_for :users, :controllers => {:sessions => "sessions", :registrations => "registrations", :confirmations => "confirmations"}
  
  #users
  get "/settings", to: "users#edit", as: "edit_user"
  put "/:user_id/update", to: "users#update", as: "update_user"
  get "/integrations", to: "users#integrations", as: "integrations_user"

  #accounts
  get "new", to: "accounts#new", as: "new_accounts"
  post "create", to: "accounts#create", as: "accounts"
  put "/:user_id/:account_id/update", to: "accounts#update", as: "update_account"
  get "/:user_id/:account_id/settings", to: "accounts#edit", as: "edit_account"
  get "/:user_id/:account_id/delete", to: "accounts#destroy", as: "delete_account"  
  
  #collaboration
  post "/:user_id/:account_id/collaboration", to: "permissions#create", as: "user_account_permissions"
  get "/:user_id/:account_id/collaboration", to: "permissions#index", as: "user_account_permissions"
  get "/:user_id/:account_id/collaboration/:id/delete", to: "permissions#destroy", as: "user_account_permissions_delete"
  
  #transfer account
  post '/:user_id/:account_id/transfer', to: "accounts#transfer", as: "transfer_user_account"

  #specfic files
  get "/:user_id/:account_id/readme.md", to: "data_filzs#readme", as: "readme_user_account_data_filz"
  get "/:user_id/:account_id/license.md", to: "data_filzs#license", as: "license_user_account_data_filz"
  
  #files
  get "/:user_id/:account_id/data", to: "data_filzs#index", as: "user_account_data_filzs"
  get "/:user_id/:account_id/data/new", to: "data_filzs#new", as: "new_user_account_data_filzs"
  get "/:user_id/:account_id/data/apis", to: "data_filzs#apis", as: "apis_user_account_data_filzs"
  post "/:user_id/:account_id/data/apis/pull", to: "data_filzs#pull", as: "pull_user_account_data_filzs"
  get "/:user_id/:account_id/articles/:file_id/csv", to: "data_filzs#csv", as: "csv_user_account_data_filz"
  get "/:user_id/:account_id/data/:file_id/edit", to: "data_filzs#edit", as: "edit_user_account_data_filz"
  post "/:user_id/:account_id/data/create", to: "data_filzs#create", as: "create_user_account_data_filzs"
  put "/:user_id/:account_id/data/:file_id/update", to: "data_filzs#update", as: "update_user_account_data_filz"
  get "/:user_id/:account_id/data/:file_id/delete", to: "data_filzs#destroy", as: "delete_user_account_data_filz"
  get "/:user_id/:account_id/data/:file_id/raw", to: "data_filzs#raw", as: "raw_user_account_data_filz"
  get "/:user_id/:account_id/data/:file_id", to: "data_filzs#show", as: "user_account_data_filz"
  
  #articles
  get "/:user_id/:account_id/articles", to: "cms_articles#index", as: "user_account_cms_articles"
  get "/:user_id/:account_id/articles/new", to: "cms_articles#new", as: "new_user_account_cms_articles"
  get "/:user_id/:account_id/articles/:file_id/edit", to: "cms_articles#edit", as: "edit_user_account_cms_article"
  post "/:user_id/:account_id/articles/create", to: "cms_articles#create", as: "create_user_account_cms_articles"
  put "/:user_id/:account_id/articles/:file_id/update", to: "cms_articles#update", as: "update_user_account_cms_article"
  get "/:user_id/:account_id/articles/:file_id/delete", to: "cms_articles#destroy", as: "delete_user_account_cms_article"
  get "/:user_id/:account_id/articles/:file_id", to: "cms_articles#show", as: "user_account_cms_article"
  
  #tags
  post "/:user_id/:account_id/tags/create", to: "core_tags#create", as: "create_user_account_core_tags"
  put "/:user_id/:account_id/tags/:tag_id/update", to: "core_tags#update", as: "update_user_account_core_tag"
  get "/:user_id/:account_id/tags/:tag_id/delete", to: "core_tags#destroy", as: "delete_user_account_core_tag"
  get "/:user_id/:account_id/tags/:tag_id", to: "core_tags#show", as: "user_account_core_tag"
  
  #images
  get "/:user_id/:account_id/images", to: "cms_images#index", as: "user_account_cms_images"
  get "/:user_id/:account_id/images/new", to: "cms_images#new", as: "new_user_account_cms_images"
  get "/:user_id/:account_id/images/:file_id/edit", to: "cms_images#edit", as: "edit_user_account_cms_image"
  post "/:user_id/:account_id/images/create", to: "cms_images#create", as: "create_user_account_cms_images"
  put "/:user_id/:account_id/images/:file_id/update", to: "cms_images#update", as: "update_user_account_cms_image"
  get "/:user_id/:account_id/images/:file_id/delete", to: "cms_images#destroy", as: "delete_user_account_cms_image"
  get "/:user_id/:account_id/images/:file_id", to: "cms_images#show", as: "user_account_cms_image"
  
  #viz
  get "/:user_id/:account_id/visualizations", to: "viz_vizs#index", as: "user_account_viz_vizs"
  get "/:user_id/:account_id/visualizations/new", to: "viz_vizs#new", as: "new_user_account_viz_vizs"
  get "/:user_id/:account_id/visualizations/:file_id/map", to: "viz_vizs#map", as: "map_user_account_viz_viz"  
  get "/:user_id/:account_id/visualizations/:file_id/edit", to: "viz_vizs#edit", as: "edit_user_account_viz_viz"
  post "/:user_id/:account_id/visualizations/create", to: "viz_vizs#create", as: "create_user_account_viz_vizs"
  put "/:user_id/:account_id/visualizations/:file_id/update", to: "viz_vizs#update", as: "update_user_account_viz_viz"
  get "/:user_id/:account_id/visualizations/:file_id/put_map", to: "viz_vizs#put_map", as: "put_map_user_account_viz_viz"
  get "/:user_id/:account_id/visualizations/:file_id/delete", to: "viz_vizs#destroy", as: "delete_user_account_viz_viz"
  get "/:user_id/:account_id/visualizations/:file_id", to: "viz_vizs#show", as: "user_account_viz_viz"

  #most specific routes come last
  get "/:user_id/:account_id", to: "accounts#show", as: "user_account"
  get "/:user_id", to: "users#show", as: "user"
  
  #root
  root :to => 'static_pages#index'
  
end