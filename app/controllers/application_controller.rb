class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :project_member


  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end


  def authenticate_user
    unless current_user
      session[:initial_path] = request.fullpath
     flash[:danger] = "You must sign in"
     redirect_to sign_in_path
    end
  end

  def project_owner
    @project = Project.find(params[:id])
    if !(current_user.is_project_owner(@project))
      flash[:danger] = "You do not have access"
      redirect_to projects_path
    end
  end

  def current_user_or_admin(user)
    user == current_user || current_user.admin
  end

  def project_member
    project = Project.find(params[:id])
    unless current_user.admin || current_user.is_project_member(project)
      flash[:danger] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

  class AccessDenied < StandardError
  end
  rescue_from AccessDenied, with: :four_oh_four_error

  def four_oh_four_error
    render file: 'public/404.html', status: :not_found, layout: false
  end
end
