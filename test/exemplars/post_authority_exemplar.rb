class PostAuthority < ActiveRecord::Base
  generator_for :title, :method => :next_post_title
  generator_for :permlink, :method => :next_permlink

  def self.next_post_title
    @post_index ||= 0
    @post_index += 1
    "Rails Post: post number #{@post_index}" 
  end
  
  def self.next_permlink
    @link_index ||= 0
    @link_index += 1
    "http://myrailsblog.com/posts/#{@link_index}"
  end
end
