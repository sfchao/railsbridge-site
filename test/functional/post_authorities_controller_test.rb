require 'test_helper'

class PostAuthoritiesControllerTest < ActionController::TestCase
  should_have_before_filter :require_team_lead_user, :except => [ :get_auth ]
  
  context "on GET to :index" do
    setup do
      controller.stubs(:require_team_lead_user).returns(true)
      @post = PostAuthority.generate!
      PostAuthority.stubs(:all).returns([@post])
      get :index
    end
    
    should_assign_to(:posts) { [@post] }
    should_respond_with :success
    should_render_template :index
    should_not_set_the_flash
  end
  
  context "on GET to :edit" do
    setup do
      controller.stubs(:require_team_lead_user).returns(true)
      @post = PostAuthority.generate!
      PostAuthority.stubs(:find).with(@post.id.to_s).returns(@post)
      get :edit, :id => @post.id
    end
    
    should_assign_to(:post) { @post }
    should_respond_with :success
    should_not_set_the_flash
    should_render_template :edit
  end
  
  context "on PUT to :update" do
    setup do
      controller.stubs(:require_team_lead_user).returns(true)
      @post = PostAuthority.generate!
      PostAuthority.stubs(:find).with(@post.id).returns(@post)
    end

    context "with successful update" do
      setup do
        PostAuthority.any_instance.stubs(:update_attributes).returns(true)
        put :update, :id => @post.id, :post_authority => { :id => @post.id, :title => "Rails Rocks", :permlink => 'http:/www.stam.com'}
      end
      
      should_assign_to(:post) { @post }
      should_respond_with :redirect
      should_set_the_flash_to "Post successfully updated"
      should_redirect_to("The posts page") { post_authorities_url }
    end
    
    context "with unsuccessful update" do
      setup do
        PostAuthority.any_instance.stubs(:update_attributes).returns(false)
        put :update, :id => @post.id, :post_authority => { :id => @post.id, :title => "Rails Rocks", :permlink => 'http:/www.stam.com'}
      end
      
      should_assign_to(:post) { @post }
      should_respond_with :success
      should_set_the_flash_to "Errors were found during saving"
      should_render_template :edit
    end
  end
  
end
