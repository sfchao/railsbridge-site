require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  
  should_have_before_filter :require_team_lead_user, :except => [ :index, :show ]
  should_have_before_filter :find_document, :only => [ :show, :edit, :update, :destroy ]

  context "on GET to :index" do
    setup do
      @the_document = Document.generate!
      Document.stubs(:all).returns([@the_document])
      get :index
    end
    
    should_assign_to(:documents) { [@the_document] }
    should_assign_to(:page_title) { "RailsBridge Documents" }
    should_respond_with :success
    should_render_template :index
    should_not_set_the_flash
  end
  
  context "on GET to :show" do
    setup do
      @the_document = Document.generate!
      get :show, :id => @the_document.id
    end
    
    should_assign_to(:document) { @the_document }
    should_assign_to(:page_title) { @the_document.name }
    should_respond_with :success
    should_not_set_the_flash
    should_render_template :show
  end

  context "on GET to :new" do
    setup do
      controller.stubs(:require_team_lead_user).returns(true)
      @the_document = Document.generate!
      Document.stubs(:new).returns(@the_document)
      get :new
    end
    
    should_assign_to(:document) { @the_document }
    should_assign_to(:page_title) { "New RailsBridge Document" }
    should_respond_with :success
    should_render_template :new
    should_not_set_the_flash
  end

  context "on POST to :create" do
    setup do
      controller.stubs(:require_team_lead_user).returns(true)
      @current_user = User.generate
      controller.stubs(:current_user).returns(@current_user)
      @the_document = Document.generate!(:user_id => nil)
      Document.stubs(:new).returns(@the_document)
    end
    
    context "with successful creation" do
      setup do
        @the_document.stubs(:save).returns(true)
        post :create, :document => { :name => "New Document" }
      end

      should_assign_to(:document) { @the_document }
      should_respond_with :redirect
      should_set_the_flash_to "Document was successfully created."
      should_redirect_to("the document page") { document_url(@the_document) }
      
      should "set the document's user" do
        assert_equal @current_user.id, @the_document.user_id
      end
    end
    
    context "with failed creation" do
      setup do
        @the_document.stubs(:save).returns(false)
        post :create, :document => { :name => "New Document" }
      end
      
      should_assign_to(:document) { @the_document }
      should_respond_with :success
      should_not_set_the_flash
      should_render_template :new
    end
  end
  
  context "on GET to :edit" do
    setup do
      controller.stubs(:require_team_lead_user).returns(true)
      @the_document = Document.generate!
      Document.stubs(:find).with(@the_document.id.to_s).returns(@the_document)
      get :edit, :id => @the_document.id
    end
    
    should_assign_to(:document) { @the_document }
    should_assign_to(:page_title) { "Edit #{@the_document.name}"}
    should_respond_with :success
    should_not_set_the_flash
    should_render_template :edit
  end

  context "on PUT to :update" do
    setup do
      controller.stubs(:require_team_lead_user).returns(true)
      @the_document = Document.generate!
      Document.stubs(:find).with(@the_document.id.to_s).returns(@the_document)
    end

    context "with successful update" do
      setup do
        Document.any_instance.stubs(:update_attributes).returns(true)
        put :update, :id => @the_document.id, :document => { :id => @the_document.id, :name => "New Name" }
      end
      
      should_assign_to(:document) { @the_document }
      should_respond_with :redirect
      should_set_the_flash_to "Document was successfully updated."
      should_redirect_to("the document page") { document_url(@the_document) }
    end
    
    context "with failed update" do
      setup do
        Document.any_instance.stubs(:update_attributes).returns(false)
        put :update, :id => @the_document.id, :document => { :id => @the_document.id, :name => "New Name" }
      end
      
      should_assign_to(:document) { @the_document }
      should_respond_with :success
      should_not_set_the_flash
      should_render_template :edit
    end
  end
  
  context "on DELETE to :destroy" do
    setup do
      controller.stubs(:require_team_lead_user).returns(true)
      @the_document = Document.generate!
      Document.stubs(:find).with(@the_document.id.to_s).returns(@the_document)
      delete :destroy, :id => @the_document.id
    end
    
    should_respond_with :redirect
    should_set_the_flash_to "Document was deleted."
    should_redirect_to("the documents page") { documents_path }
  end
  
end
