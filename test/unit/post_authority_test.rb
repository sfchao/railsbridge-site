require 'test_helper'

class PostAuthorityTest < ActiveSupport::TestCase

  should_allow_mass_assignment_of :title, :permlink
  should_not_allow_mass_assignment_of :created_at, :updated_at, :id
  should_validate_presence_of :title, :permlink
  
  
  context "a new post authority" do
    setup {
      @post = PostAuthority.generate!
    }
    should_validate_uniqueness_of :permlink
    
    should "have a 'pending approval' (0) status" do
      assert @post.status.zero?
    end
  end
  
end
