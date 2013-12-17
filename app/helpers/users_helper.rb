module UsersHelper
  def current_user
    @current_user ||= find_user
  end

  def find_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def ensure_user
    unless current_user
      redirect_to root_url, :notice => "You must be logged in to do that!"
    end
  end

  def is_admin?
    current_user && current_user.admin
  end
end