module StaticPagesHelper
	def picfeed
		pics = Collection.where('photo_updated_at >= ?', 6.weeks.ago).order(photo_updated_at: :desc)
    	pics.take(8)
    end

    def splash_picfeed
		pics = Collection.where('photo_updated_at >= ?', 4.weeks.ago).order(imagevotes_count: :desc, photo_updated_at: :desc)
    	pics.take(6)
    end


end
