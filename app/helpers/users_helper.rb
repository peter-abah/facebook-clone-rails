module UsersHelper
  def user_info_exists?(user)
    return false if (user.birthday.nil?) &&
                    (user.current_city.nil? || user.current_city.empty?)

    true
  end
end
