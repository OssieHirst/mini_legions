module StaticPagesHelper
	def picfeed
		pics = Collection.where('photo_updated_at >= ?', 2.months.ago)
    	pics.take(5)
    end


end
