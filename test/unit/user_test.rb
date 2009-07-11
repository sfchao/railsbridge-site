require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should_be_authentic
  
  should_have_many :documents
  
  should_allow_mass_assignment_of :login, :password, :password_confirmation, :first_name, :last_name, :email
  should_not_allow_mass_assignment_of :crypted_password, :password_salt, :persistence_token, :login_count, :last_request_at, :last_login_at,
    :current_login_at, :last_login_ip, :current_login_ip, :admin, :created_at, :updated_at, :id, :team_lead
  
  context "#deliver_password_reset_instructions!" do
    setup do
      activate_authlogic
      @user = User.generate!
      Notifier.stubs(:deliver_password_reset_instructions)
    end
    
    should "reset the perishable token" do
      @user.expects(:reset_perishable_token!)
      @user.deliver_password_reset_instructions!
    end
    
    should "send the reset mail" do
      Notifier.expects(:deliver_password_reset_instructions).with(@user)
      @user.deliver_password_reset_instructions!
    end
  end
  
  context "#full_name" do
    should "concatenate first and last name" do
      user = User.generate(:first_name => "Betty", :last_name => "Boop")
      assert_equal "Betty Boop", user.full_name
    end
    
    should "handle blank last name" do
      user = User.generate(:first_name => "Betty", :last_name => nil)
      assert_equal "Betty", user.full_name
    end

    should "handle blank first name" do
      user = User.generate(:first_name => nil, :last_name => "Boop")
      assert_equal "Boop", user.full_name
    end

    should "handle missing names" do
      user = User.generate(:first_name => nil, :last_name => nil)
      assert_equal "", user.full_name
    end
  end
  
end



