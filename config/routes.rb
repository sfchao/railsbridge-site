ActionController::Routing::Routes.draw do |map|

  map.resource :account, :controller => "users"
  map.resources :documents
  map.resources :news_items, :collection => { :feed => :get }
  map.resources :password_resets
  map.resources :projects
  map.resources :users
  map.resource :user_session
  map.resources :post_authorities, :controller => 'post_authorities', :collection => {:bulk_destroy => :post, :bulk_process => :post, :get_auth => :any}

  map.root :controller => "pages", :action => "home"
  
  map.mission 'mission', :controller => "pages", :action => "mission"
  map.home 'home', :controller => "pages", :action => "home"
  map.about 'about', :controller => "pages", :action => "about"
  map.sponsors 'sponsors', :controller => 'pages', :action => 'sponsors'
  map.posts 'posts', :controller => 'posts', :action => 'posts'
  map.help 'help', :controller => "pages", :action => "help"
  map.badge 'badge', :controller => "pages", :action => "badge"
  map.login 'login', :controller => "user_sessions", :action => "new"
  map.logout 'logout', :controller => "user_sessions", :action => "destroy"
  map.register 'register', :controller => "users", :action => "new"
  
  map.pages 'pages/:action', :controller => "pages"
end
