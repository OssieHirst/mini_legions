module UsersHelper
  def current_user?(user)
    user == current_user
  end

  def not_admin?(user)
  current_user.admin? && !current_user?(user)
  end

end