class UsersController < ApplicationController

  def new
    @curr_user = User.new()
  end

  def create
    @curr_user = User.new(user_params)
    puts @curr_user
    if @curr_user.save
      flash[:success] = "Welcome!"
      redirect_to '/'
      session[:user_id] = @curr_user.id
    else
      render 'new'
    end
  end

  def show
    @curr_user = User.find_by_id(params[:id])
    @yards = @curr_user.yards
  end

  def edit
  @curr_user = User.find_by_id(params[:id])
  end

  def update
    @curr_user = User.find_by_id(params[:id])
    @curr_user.update(user_params)
    redirect_to user_path_url(@curr_user)
  end


  private
  def user_params
    params.require(:user).permit(:email,:name, :age, :bio, :is_hosting, :is_traveling, :gear, :password, :password_confirmation)
  end

end
