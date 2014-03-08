module ApplicationHelper
	# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Mini Legions"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  # Pluralize without showing the count.
  def simple_pluralize count, singular, plural=nil
    ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize))
  end
end
