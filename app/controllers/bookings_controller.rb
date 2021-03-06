class BookingsController < ActionController::Base

def new
  puts params[:yard_id]
  @curr_user = User.find_by_id(session[:user_id])
  @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
  @booking = Booking.new
  @yard = Yard.find_by_id(params[:yard_id])
  puts @yard
  @host = User.find_by_id(@yard.user.id)
  @camper= User.find_by_id(session[:user_id])
end

def destroy
  @curr_user = User.find_by_id(session[:user_id])
  @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
  @booking = Booking.find_by_id(params[:id])
  if @booking.destroy
    redirect_to :back
    flash[:error] = "Booking for " + @booking.start_date.to_s + " to " + @booking.end_date.to_s + " was deleted"
  end
end

def create
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
    redirect_to sent_bookings_path_url(@curr_user)
  else
    flash[:error]= @booking.errors.full_messages.join(", ")
    redirect_to :back
  end
  @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
end

def sent
  @curr_user = User.find_by_id(session[:user_id])
  @pending_bookings = Booking.where(camper_id: @curr_user.id).where(is_answered: false)
  @answered_bookings = Booking.where(camper_id: @curr_user.id).where(is_answered: true)
  @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
end

def incoming
  @curr_user = User.find_by_id(session[:user_id])
  @incoming_pending_bookings = Booking.where(host_id: @curr_user.id).where(is_answered: false)
  @incoming_answered_bookings = Booking.where(host_id: @curr_user.id).where(is_accepted: true)
  @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
end

def answered
  @curr_user = User.find_by_id(session[:user_id])
  @incoming_answered_bookings = Booking.where(host_id: @curr_user.id).where(is_accepted: true)
  @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
end

def update
  @curr_user = User.find_by_id(session[:user_id])
  @booking = Booking.find_by_id(params[:id])
  @booking.update(update_booking_params)
  redirect_to :back
  @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
end

private

def create_booking_params
  params.require(:yard_id)
end

def booking_params
  params.require(:booking).permit(:group_size, :start_date, :end_date, :yard_id, :pets_or_kids, :is_accepted, :is_answered)
end

def destroy_booking_params
  params.require(:booking_id)
end

def update_booking_params
  params.permit(:is_accepted, :is_answered)
end
end
