class Donor < ActiveRecord::Base
  
  validates_presence_of :name, :donation
  validates_numericality_of :donation, :integer_only => true, :greater_than => 0
  
  def rank
    case donation.to_i
    when 0..50
      "Silver"
    when 51..200
      "Gold"
    else
      if donation > 200
        "Ruby"
      else
        "Silver"
      end
    end
  end
end
