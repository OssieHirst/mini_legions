module StaticPagesHelper
	def picfeed
		pics = Collection.where('photo_updated_at >= ?', 5.days.ago)
    	pics.take(8)
    end

    def splash_picfeed
		pics = Collection.where('photo_updated_at >= ?', 1.week.ago)
    	pics.take(6)
    end


end
