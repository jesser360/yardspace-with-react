class BookingsController < ActionController::Base

def new
  @booking = Booking.new
  @yard = Yard.find_by_id(params[:yard_id.to_s])
  @host = User.find_by_id(@yard.user.id.to_s)
  @camper= User.find_by_id(session[:user_id])
end


def create
  puts "WERE IN CREATE BOOKINGS"
  puts params[:group_size]
  puts params[:yard_id]

  @user= User.find_by_id(session[:user_id])
@booking = Booking.new(booking_params)
if @booking.save
redirect_to user_path_url(@user)
else
  flash[:error]= @booking.errors.full_messages.join(", ")
  redirect_to :back
end

end

def create_booking_params
  params.require(:yard_id)
end

def booking_params
  params.permit(:group_size, :start_date, :end_date, :yard_id)
end

end
