class PagesController < ApplicationController

  def home
    if session[:user_id]
    @curr_user = User.find_by_id(session[:user_id])
    @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
    end
end


end
