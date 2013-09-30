class Miniature < ActiveRecord::Base
	validates :name, presence: true, length: { maximum: 50 }
	validates :material, presence: true
	validates_date :release_date, :allow_blank => true

  def name=(s)
    super s.titleize
  end

end