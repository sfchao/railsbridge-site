class PostAuthority < ActiveRecord::Base
  
  validates_presence_of :title, :permlink
  attr_accessible :title, :permlink
  validates_uniqueness_of :permlink
  
end
