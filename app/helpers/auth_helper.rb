module AuthHelper

  def super_access
    unless current_user.superman?
      return unauthorized
    end
    true
  end

  def owner_access
    unless current_user.owns?(current_restaurant) || current_user.superman?
      return unauthorized
    end
    true
  end

  def employee_access
    unless current_user.works_for?(current_restaurant) ||
      current_user.owns?(current_restaurant) || current_user.superman?
      return unauthorized
    end
    true
  end

  def unauthorized
    redirect_to root_url, :notice => "You're not authorized to do that!"
    false
  end
end
