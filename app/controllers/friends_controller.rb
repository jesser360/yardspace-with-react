class FriendsController < ApplicationController

  def create
    @curr_user = User.find_by_id(session[:user_id])
    @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
    @friend = Friend.new()
    @friend.me_id = @curr_user.id.to_s
    @friend.you_id = params[:id]
    @friend.is_accepted = false
      if @friend.save
        redirect_to user_path_url(@curr_user)
      else
        redirect_to :back
      end
  end

  def index
    @curr_user = User.find_by_id(session[:user_id])
    @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
    @friends = Friend.where(me_id: @curr_user).where(is_accepted: true)
    @friendz = Friend.where(you_id: @curr_user).where(is_accepted: true)
    @all_friends = @friends + @friendz
    @pending_friends = Friend.where(you_id: @curr_user).where(is_accepted: false)

  end

  def destroy
    @curr_user = User.find_by_id(session[:user_id])
    @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
    @friend = Friend.where(me_id: @curr_user).where(you_id: params[:id])
    @ship = Friend.where(you_id: @curr_user).where(me_id: params[:id])
    @friendship = @friend + @ship
    @friendship.each do |x|
      x.delete
      x.save
    end
    redirect_to :back
  end

  def accept
    @curr_user = User.find_by_id(session[:user_id])
    @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
    @friend = Friend.where(you_id: @curr_user).where(me_id: params[:id])
    @friend.each do |y|
      y.is_accepted = true
      y.save
    end
    redirect_to :back
  end

  private

  def friend_params
    params.permit(:id)
  end
end
