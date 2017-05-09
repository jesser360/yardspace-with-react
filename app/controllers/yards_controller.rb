
class YardsController < ApplicationController
  require 'httparty'
  include HTTParty

def new
  @yard = Yard.new
  @curr_user = User.find_by_id(current_user.id.to_s)
  @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
end


def create
  @curr_user = User.find_by_id(current_user.id.to_s)
  @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
  @yard = Yard.new()
  @yard.title = yard_params[:title]
  @yard.description = yard_params[:description]
  @yard.city = yard_params[:city].to_i
  @yard.zipcode = yard_params[:zipcode]
  @yard.kid_and_pet_friendly = yard_params[:kid_and_pet_friendly]
  @yard.fire_friendly = yard_params[:fire_friendly]
  @yard.rating = 0
  @yard.r_count = 0
  @yard.user = @curr_user
  if @yard.save
    redirect_to user_path_url(@curr_user)
  else
    flash[:error] = @yard.errors.full_messages.join(", ")
    redirect_to :back
  end
end

def show
  if(logged_in?)
  @comment = Comment.new()
  @curr_user = User.find_by_id(current_user.id.to_s)
  @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
  end
  @yard = Yard.find_by_id(params[:id])
  @comments = Comment.where(yard_id: @yard.id.to_s)
end

def destroy
  @yard = Yard.find_by_id(params[:id])
  @bookings = Booking.where(yard_id: @yard.id.to_s)
  @bookings.delete_all
  if @yard.destroy
    flash[:error] = @yard.title + 'was deleted, never to be seen again..'
    redirect_to :back
  else
    flash[:error] = "try deleting again, something went wrong"
  end
end

def edit
  @curr_user = User.find_by_id(current_user.id.to_s)
  @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
  @yard = Yard.find_by_id(params[:id])
end

def update
  @curr_user = User.find_by_id(current_user.id.to_s)
  @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
  @yard = Yard.find_by_id(params[:id])
  if @yard.update(yard_params)
    redirect_to user_path_url(@curr_user)
  else
    flash[:error] = @yard.errors.full_messages
    redirect_to :back
  end
end

def updateRating
  @curr_user = User.find_by_id(current_user.id.to_s)
  @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
  @yard = Yard.find_by_id(params[:id])
  @yard.r_count += 1
  @yard.rating += yard_rating_params[:rating].to_i
  @yard.save
  cookies[:rated] = '.' if cookies[:rated].nil?
  cookies[:rated] += @yard.id.to_s + '.'
  redirect_to :back
end

def cities
  @curr_user = User.find_by_id(session[:user_id]) if session[:user_id]
  @inbox = Message.where(receiver_id: @curr_user).where(is_read: false)
  @yards = Yard.where(city: params[:city])
  @city = params[:city]
  weather_hash = fetch_weather params[:city]
  assign_values(weather_hash)
end

private

def yard_params
  params.require(:yard).permit(:title, :description, :kid_and_pet_friendly, :fire_friendly, :zipcode, :city, :safety)
end

def yard_rating_params
  params.require(:yard).permit(:rating)
end


attr_accessor :temperature, :icon
def initialize

end

def fetch_weather city
  puts city
    if city == 'sf_bay_area'
      zipcode = 94107
    elsif city == 'santa_cruz'
      zipcode = 95060
    elsif city == 'lake_tahoe'
      zipcode = 96150
    elsif city == 'yosemite'
      zipcode = 95389
    elsif city == 'santa_barbara'
      zipcode = 93101
    elsif city == 'sonoma'
      zipcode = 95476
    elsif city == 'los_angeles'
      zipcode = 90001
    end
   @response = HTTParty.get("http://api.openweathermap.org/data/2.5/forecast/daily?zip=#{zipcode}&cnt=6&APPID=56816b6400cf26a5068b34d20251372f")
 end


  def assign_values(weather_hash)
    require 'date'
         @forecast_response = weather_hash.parsed_response['city']
         @date0 = weather_hash.parsed_response['list'][0]['dt']
         @day0_date = Time.at(@date0).to_date.strftime("%m/%d")
         @day0 = weather_hash.parsed_response['list'][0]['temp']['day']
         @day0_temp = ((1.8*(@day0-273))+32).floor
         @night0 = weather_hash.parsed_response['list'][0]['temp']['night']
         @night0_temp = ((1.8*(@night0-273))+32).floor
         @day0_icon = weather_hash.parsed_response['list'][0]['weather'][0]['icon']
         @day0_des = weather_hash.parsed_response['list'][0]['weather'][0]['description']

         @date1 = weather_hash.parsed_response['list'][1]['dt']
         @day1_date = Time.at(@date1).to_date.strftime("%m/%d")
         @day1 = weather_hash.parsed_response['list'][1]['temp']['day']
         @day1_temp = ((1.8*(@day1-273))+32).floor
         @night1 = weather_hash.parsed_response['list'][1]['temp']['night']
         @night1_temp = ((1.8*(@night1-273))+32).floor
         @day1_icon = weather_hash.parsed_response['list'][1]['weather'][0]['icon']
         @day1_des = weather_hash.parsed_response['list'][1]['weather'][0]['description']

         @date2 = weather_hash.parsed_response['list'][2]['dt']
         @day2_date = Time.at(@date2).to_date.strftime("%m/%d")
         @day2 = weather_hash.parsed_response['list'][2]['temp']['day']
         @day2_temp = ((1.8*(@day2-273))+32).floor
         @night2 = weather_hash.parsed_response['list'][2]['temp']['night']
         @night2_temp = ((1.8*(@night2-273))+32).floor
         @day2_icon = weather_hash.parsed_response['list'][2]['weather'][0]['icon']
         @day2_des = weather_hash.parsed_response['list'][2]['weather'][0]['description']

         @date3 = weather_hash.parsed_response['list'][3]['dt']
         @day3_date = Time.at(@date3).to_date.strftime("%m/%d")
         @day3 = weather_hash.parsed_response['list'][3]['temp']['day']
         @day3_temp = ((1.8*(@day3-273))+32).floor
         @night3 = weather_hash.parsed_response['list'][3]['temp']['night']
         @night3_temp = ((1.8*(@night3-273))+32).floor
         @day3_icon = weather_hash.parsed_response['list'][3]['weather'][0]['icon']
         @day3_des = weather_hash.parsed_response['list'][3]['weather'][0]['description']

         @date4 = weather_hash.parsed_response['list'][4]['dt']
         @day4_date = Time.at(@date4).to_date.strftime("%m/%d")
         @day4 = weather_hash.parsed_response['list'][4]['temp']['day']
         @day4_temp = ((1.8*(@day4-273))+32).floor
         @night4 = weather_hash.parsed_response['list'][4]['temp']['night']
         @night4_temp = ((1.8*(@night4-273))+32).floor
         @day4_icon = weather_hash.parsed_response['list'][4]['weather'][0]['icon']
         @day4_des = weather_hash.parsed_response['list'][4]['weather'][0]['description']

         @date5 = weather_hash.parsed_response['list'][5]['dt']
         @day5_date = Time.at(@date5).to_date.strftime("%m/%d")
         @day5 = weather_hash.parsed_response['list'][5]['temp']['day']
         @day5_temp = ((1.8*(@day5-273))+32).floor
         @night5 = weather_hash.parsed_response['list'][5]['temp']['night']
         @night5_temp = ((1.8*(@night5-273))+32).floor
         @day5_icon = weather_hash.parsed_response['list'][5]['weather'][0]['icon']
         @day5_des = weather_hash.parsed_response['list'][5]['weather'][0]['description']

   end

end
