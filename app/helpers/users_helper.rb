module UsersHelper
  def current_user?(user)
    user == current_user
  end

  def not_admin?(user)
    current_user.admin? && !current_user?(user)
  end
  
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=48&d=mm"
    image_tag(gravatar_url, alt: user.name, size: "48x48", class: "gravatar")
  end

  def large_gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=210&d=mm"
    image_tag(gravatar_url, alt: user.name, class: "large_gravatar")
  end

  def med_gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=80&d=mm"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def paintedfeed
    pics = @user.collections.where('photo_updated_at >= ?', 6.months.ago).order(photo_updated_at: :desc)
      pics.take(8)
  end
  
end