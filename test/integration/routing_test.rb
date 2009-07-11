require 'test_helper'

class RoutingTest < ActionController::IntegrationTest
  context "routing" do
  
    should_route :get, "/account/new", :controller => "users", :action => "new"
    should_route :get, "/account/edit", :action=>"edit", :controller=>"users"
    should_route :get, "/account", :action=>"show", :controller=>"users"
    should_route :put, "/account", :action=>"update", :controller=>"users"
    should_route :delete, "/account", :action=>"destroy", :controller=>"users"
    should_route :post, "/account", :action=>"create", :controller=>"users"
    should_route :get, "/documents", :action=>"index", :controller=>"documents"
    should_route :post, "/documents", :action=>"create", :controller=>"documents"
    should_route :get, "/documents/new", :action=>"new", :controller=>"documents"
    should_route :get, "/documents/1/edit", :action=>"edit", :controller=>"documents", :id => 1
    should_route :get, "/documents/1", :action=>"show", :controller=>"documents", :id => 1
    should_route :put, "/documents/1", :action=>"update", :controller=>"documents", :id => 1
    should_route :delete, "/documents/1", :action=>"destroy", :controller=>"documents", :id => 1
    should_route :get, "/news_items/feed", :action=>"feed", :controller=>"news_items"
    should_route :get, "/news_items", :action=>"index", :controller=>"news_items"
    should_route :post, "/news_items", :action=>"create", :controller=>"news_items"
    should_route :get, "/news_items/new", :action=>"new", :controller=>"news_items"
    should_route :get, "/news_items/1/edit", :action=>"edit", :controller=>"news_items", :id => 1
    should_route :get, "/news_items/1", :action=>"show", :controller=>"news_items", :id => 1
    should_route :put, "/news_items/1", :action=>"update", :controller=>"news_items", :id => 1
    should_route :delete, "/news_items/1", :action=>"destroy", :controller=>"news_items", :id => 1
    should_route :get, "/password_resets", :action=>"index", :controller=>"password_resets"
    should_route :post, "/password_resets", :action=>"create", :controller=>"password_resets"
    should_route :get, "/password_resets/new", :action=>"new", :controller=>"password_resets"
    should_route :get, "/password_resets/1/edit", :action=>"edit", :controller=>"password_resets", :id => 1
    should_route :get, "/password_resets/1", :action=>"show", :controller=>"password_resets", :id => 1
    should_route :put, "/password_resets/1", :action=>"update", :controller=>"password_resets", :id => 1
    should_route :delete, "/password_resets/1", :action=>"destroy", :controller=>"password_resets", :id => 1
    should_route :get, "/projects", :action=>"index", :controller=>"projects"
    should_route :post, "/projects", :action=>"create", :controller=>"projects"
    should_route :get, "/projects/new", :action=>"new", :controller=>"projects"
    should_route :get, "/projects/1/edit", :action=>"edit", :controller=>"projects", :id => 1
    should_route :get, "/projects/1", :action=>"show", :controller=>"projects", :id => 1
    should_route :put, "/projects/1", :action=>"update", :controller=>"projects", :id => 1
    should_route :delete, "/projects/1", :action=>"destroy", :controller=>"projects", :id => 1
    should_route :get, "/users", :action=>"index", :controller=>"users"
    should route(:post, "/users").to(:action=>"create", :controller=>"users")
    should route(:get, "/users/new").to(:action=>"new", :controller=>"users")
    should_route :get, "/users/1/edit", :action=>"edit", :controller=>"users", :id => 1
    should_route :get, "/users/1", :action=>"show", :controller=>"users", :id => 1
    should_route :put, "/users/1", :action=>"update", :controller=>"users", :id => 1
    should_route :delete, "/users/1", :action=>"destroy", :controller=>"users", :id => 1
    should_route :get, "/user_session/new", :action=>"new", :controller=>"user_sessions"
    should_route :get, "/user_session/edit", :action=>"edit", :controller=>"user_sessions"
    should_route :get, "/user_session", :action=>"show", :controller=>"user_sessions"
    should_route :put, "/user_session", :action=>"update", :controller=>"user_sessions"
    should_route :delete, "/user_session", :action=>"destroy", :controller=>"user_sessions"
    should_route :post, "/user_session", :action=>"create", :controller=>"user_sessions"
    should_route :get, "/", :action=>"home", :controller=>"pages"
    should_route :get, "/mission", :action=>"mission", :controller=>"pages"
    should route(:get, "/home").to(:action=>"home", :controller=>"pages")
    should_route :get, "/about", :action=>"about", :controller=>"pages"
    should_route :get, "/help", :action=>"help", :controller=>"pages"
    should route(:get, "/login").to(:action=>"new", :controller=>"user_sessions")
    should route(:get, "/logout").to(:action=>"destroy", :controller=>"user_sessions")
    should route(:get, "/register").to(:action=>"new", :controller=>"users")
    should_route :get, "/pages/foo", :controller=>"pages", :action => "foo"

  end
end
