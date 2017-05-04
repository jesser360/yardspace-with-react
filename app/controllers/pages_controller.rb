class PagesController < ApplicationController

  def home
    if session[:user_id]
    @user = User.find(session[:user_id])
  else
    @user = nil
  end
end

end
