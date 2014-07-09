module StaticPagesHelper
	def picfeed
		pics = Collection.where('photo_updated_at >= ?', 2.weeks.ago)
    	pics.take(7)
    end


end
