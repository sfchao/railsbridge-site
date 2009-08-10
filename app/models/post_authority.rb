class PostAuthority < ActiveRecord::Base
  
  validates_presence_of :title, :permlink
  attr_accessible :title, :permlink, :rails_version, :reference_module
  validates_uniqueness_of :permlink
  
  STATUS_CODES = {"0" => 'Pending Approval', "1" => "Up to date", "2" => "Out of date"}
  STATUS_TOKENS = {"0" => 'pending', "1" => "valid", "2" => "expired"}
  
  def current_status
    STATUS_CODES[self.status.to_s]
  end
  
  def current_token
    STATUS_TOKENS[self.status.to_s]
  end
  
  def self.status_tokens_for_select
    STATUS_TOKENS.to_a.collect(&:reverse).collect {|pair| pair.first.titleize}
  end
end
