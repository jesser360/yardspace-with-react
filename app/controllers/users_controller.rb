class UsersController < ApplicationController

  def new
    @curr_user = User.new()
  end

  def create
    @curr_user = User.new(user_params_create)
    if @curr_user.save
      session[:user_id] = @curr_user.id
      redirect_to '/'
    else
      flash[:error] = @curr_user.errors.full_messages
      render 'new'
    end
  end

  def show
    @curr_user = User.find_by_id(session[:user_id]) if session[:user_id]
    if @curr_user
    @friend = Friend.where(me_id: @curr_user.id).where(you_id: params[:id])
    @ship = Friend.where(you_id: @curr_user.id).where(me_id: params[:id])
    @friendship = @friend + @ship
  end
    @user = User.find_by_id(params[:id])
    @inbox = Message.where(receiver_id: @user).where(is_read: false)
    @yards = @user.yards
    @incoming_pending_bookings = Booking.where(host_id: @user.id).where(is_answered: false)
    @pending_friends = Friend.where(you_id: @curr_user).where(is_accepted: false)
  end

  def edit
  @curr_user = User.find_by_id(params[:id])
  @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
  end

  def update
    @curr_user = User.find_by_id(params[:id])
    @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
    @curr_user.update(user_params)
    redirect_to user_path_url(@curr_user)
  end


  private
  def user_params
    params.require(:user).permit(:email,:name, :age, :bio, :is_hosting, :is_traveling, :gear)
  end
  def user_params_create
    params.require(:user).permit(:email,:name,:password, :password_confirmation)
  end

end
