class BookingsController < ActionController::Base


def new
  @curr_user = User.find_by_id(session[:user_id]) if session[:user_id]
  @booking = Booking.new
  @yard = Yard.find_by_id(params[:yard_id.to_s])
  @host = User.find_by_id(@yard.user.id.to_s)
  @camper= User.find_by_id(session[:user_id])
end


def create
  puts "WERE IN CREATE BOOKINGS"
  puts "GROUP SIZE: "+ booking_params[:group_size]
  puts  booking_params[:start_date]
  puts  booking_params[:end_date]
  puts "YARD ID: " + params[:yard_id]

@curr_user= User.find_by_id(session[:user_id])
@booking = Booking.new()
@yard = Yard.find_by_id(params[:yard_id])
@booking.group_size = booking_params[:group_size]
@booking.yard_id = params[:yard_id]
@booking.camper_id = @curr_user.id.to_s
@booking.host_id = @yard.user.id.to_s
@booking.start_date = booking_params[:start_date]
@booking.end_date = booking_params[:end_date]
@booking.is_answered = false
@booking.is_accepted = false
@booking.pets_or_kids = booking_params[:pets_or_kids]
if @booking.save
  flash[:success] = "Booking made, check your schedule to confirm details"
  redirect_to user_path_url(@curr_user)
else
  flash[:error]= @booking.errors.full_messages.join(", ")
  redirect_to :back
end

end

def create_booking_params
  params.require(:yard_id)
end

def booking_params
  params.require(:booking).permit(:group_size, :start_date, :end_date, :yard_id, :pets_or_kids)
end

end
