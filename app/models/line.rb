class Line < ActiveRecord::Base  
  belongs_to :manufacturer
  has_many :minilines, dependent: :destroy
  has_many :miniatures, :through => :minilines
  has_ancestry
  has_paper_trail


  def to_param
	slug
  end
end
