ActionController::Routing::Routes.draw do |map|

  map.resource :account, :controller => "users"
  map.resources :documents
  map.resources :news_items, :collection => { :feed => :get }
  map.resources :password_resets
  map.resources :projects
  map.resources :users
  map.resource :user_session

  map.root :controller => "pages", :action => "home"

  map.mission 'mission', :controller => "pages", :action => "mission"
  map.home 'home', :controller => "pages", :action => "home"
  map.about 'about', :controller => "pages", :action => "about"
  map.sponsors 'sponsors', :controller => 'pages', :action => 'sponsors'
  map.help 'help', :controller => "pages", :action => "help"
  map.login 'login', :controller => "user_sessions", :action => "new"
  map.logout 'logout', :controller => "user_sessions", :action => "destroy"
  map.register 'register', :controller => "users", :action => "new"
  
  map.pages 'pages/:action', :controller => "pages"
end
