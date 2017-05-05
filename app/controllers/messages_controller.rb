class MessagesController < ActionController::Base

def new
  @sender = User.find_by_id(session[:user_id])
  @receiver = User.find_by_id(params[:user_id])
  @yards = @receiver.yards

end

private

def message_params
  params.require(:user_id)
end
end
