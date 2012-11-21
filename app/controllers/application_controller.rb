class ApplicationController < ActionController::Base
  protect_from_forgery

  # before_filter :log_in_first_user

  # This is just to test being logged in in development. There should be another Facebook app for development so it can be properly tested.
  def log_in_first_user
    if Rails.env.development?
      session[:user_id] = User.first.id if User.first
    end
  end

  # Use this as a before filter on controller methods you want to restrict to logged-in users. Note that this does not ensure the particular user owns a specific garden- use "must_own_garden" in gardens_controller for that.
  def authenticate_user!
    unless current_user
      flash[:error] = "Please log in first."
      redirect_to root_path and return
    end
  end

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  # Are any of the given users logged in?
  def logged_in?(*users)
    signed_in = false
    users.each do |user|
      current_user == user ? signed_in = true : nil
    end
    signed_in
  end
  helper_method :logged_in?

end
