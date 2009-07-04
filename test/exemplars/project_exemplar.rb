class Project < ActiveRecord::Base
  generator_for :name => "Great Project"
  generator_for :short_description => "This is a great project."
  generator_for :link => "http://www.example.com/great-project/"
end
