require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  
  should_have_attached_file :download
  
  should_belong_to :user
  
  should_allow_mass_assignment_of :name, :description, :user_id, :download
  should_not_allow_mass_assignment_of :created_at, :updated_at, :id
  
  should_validate_presence_of :name, :description
  
end
