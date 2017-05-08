class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    @inbox = Message.where(receiver_id: @user).where(is_read: false)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success]="You have logged in!"
      redirect_to '/'
    else
      flash.now[:danger]= "Incorrect Info"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to '/'
  end

end
