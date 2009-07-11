class Project < ActiveRecord::Base
  
  has_attached_file :site_image, :styles => { :medium => "300x173>", :thumb => "140x81>" }, :processor => :image_science
  
  attr_accessible :name, :short_description, :link, :long_description, :team_lead, :team_lead_email, :site_image
  
  validates_presence_of :name, :short_description, :link
  
end
