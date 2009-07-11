class Document < ActiveRecord::Base
  
  has_attached_file :download
  
  belongs_to :user
  
  attr_accessible :name, :description, :user_id, :download
  
  validates_presence_of :name, :description
  
end
