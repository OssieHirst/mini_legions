class Feedback < ActiveRecord::Base
	belongs_to :user
	scope :error_bug, -> { where(nature: "Error/Bug") }
	scope :comment, -> { where(nature: "Comment") }
	scope :help_me, -> { where(nature: "Help me!") }
	scope :idea_request, -> { where(nature: "Idea/Request") }
	scope :new_feedback, -> { where(status: "New") }
	scope :emailed, -> { where(status: "Emailed") }
	scope :flagged, -> { where(status: "Flagged") }
	scope :closed, -> { where(status: "Closed") }

end
