class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def require_login
  	flash[:errors] = ["You must be logged in to do that"]  if session[:user_id] == nil
    redirect_to '/sessions/new' if session[:user_id] == nil
  end

  def require_correct_user
    user = User.find(params[:id])
    flash[:errors] = ["You're not authorized to do that"] if current_user != user
    redirect_to "/users/#{current_user.id}" if current_user != user
  end
end
