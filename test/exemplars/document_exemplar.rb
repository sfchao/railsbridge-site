class Document < ActiveRecord::Base
  generator_for :name => "Board Minutes"
  generator_for :description => "Minutes of the board meeting"
  generator_for (:user_id) {User.generate.id}
end
