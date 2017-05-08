class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @curr_user = User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger]= "You need to log in first"
      redirect_to '/'
    end
  end

  def inbox
    @user = User.find_by_id(session[:user_id]) if session[:user_id]
    @inbox = Message.where(receiver_id: @user).where(is_read: false)
  end

end
