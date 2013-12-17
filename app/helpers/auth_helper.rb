module AuthHelper

  def super_access
    return unauthorized unless current_user.superman?
    true
  end

  def owner_access
    return unauthorized unless current_user.owns?(current_restaurant) || current_user.superman?
    true
  end

  def employee_access
    return unauthorized unless current_user.works_for?(current_restaurant) || current_user.owns?(current_restaurant) || current_user.superman?
    true
  end

  def unauthorized
    redirect_to root_url, :notice => "You're not authorized to do that!"
    false
  end
end
