require 'test_helper'

class PostAuthoritiesControllerTest < ActionController::TestCase
  should_have_before_filter :require_team_lead_user, :except => [ :create ]
end
