class MessagesController < ActionController::Base

def new
  @sender = User.find_by_id(session[:user_id])
  @receiver = User.find_by_id(params[:user_id])
  @yards = @receiver.yards
end

def create
  @sender = User.find_by_id(session[:user_id])
  @message = Message.new(create_message_params)
  @message.is_read = false
  @message.sender = @sender
  if @message.save
    redirect_to user_path_url(@sender)
  else
    redirect_to :back
    flash[:error] = @message.errors.full_messages
  end
end

def index
  @curr_user = User.find_by_id(session[:user_id])
  @received_messages = Message.where(receiver_id: @curr_user.id.to_s)
  @sent_messages = Message.where(sender_id: @curr_user.id.to_s)
  @all_messages = @received_messages + @sent_messages
  @ids = []
  @unique_user = []
    @all_messages.each do |message|
      if message[:receiver_id].to_s == @curr_user.id.to_s
        if @ids.include?(message[:sender_id])
          p 'exists'
        else
        @ids.push(message[:sender_id])
        end
      else
        if @ids.include?(message[:receiver_id])
          p 'exists'
        else
        @ids.push(message[:receiver_id])
        end
      end
    end
    @ids.each do |id|
      @unique_user.push(User.find_by_id(id))
      p "USERS"+ @unique_user.length.to_s
    end
end


private

def message_params
  params.require(:user_id)
end

def create_message_params
  params.require(:message).permit(:receiver_id, :message)
end
end
