class Line < ActiveRecord::Base  
  belongs_to :manufacturer
  has_ancestry

  def to_param
	slug
  end
end
