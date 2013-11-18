class Line < ActiveRecord::Base  
  has_ancestry
  belongs_to :manufacturers

  def to_param
	slug
  end
end
