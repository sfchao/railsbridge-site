class NewsItem < ActiveRecord::Base
  
  attr_accessible :headline, :lede, :body
  
  validates_presence_of :headline, :lede
  
end
