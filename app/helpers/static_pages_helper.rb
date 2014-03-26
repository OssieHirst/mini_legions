module StaticPagesHelper
	def picfeed
		pics = Collection.where('photo_updated_at >= ?', 1.day.ago)
    	pics.take(5)
    end
end
