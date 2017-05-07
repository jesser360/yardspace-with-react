class PagesController < ApplicationController

  def home
    if session[:user_id]
    @curr_user = User.find_by_id(session[:user_id])
    end
end

end
