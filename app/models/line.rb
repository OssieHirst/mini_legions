class Line < ActiveRecord::Base  
  belongs_to :manufacturer
  has_many :minilines, dependent: :destroy
  has_many :miniatures, :through => :minilines
  has_ancestry
  has_paper_trail :meta => { :comment => :comment }
  validates :name, presence: true, length: { maximum: 50 }
  attr_accessor :comment

end
