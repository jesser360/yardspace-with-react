
class YardsController < ApplicationController
  require 'httparty'
  include HTTParty

def new
  @yard = Yard.new
end


def create
  @curr_user = User.find_by_id(current_user.id.to_s)
  @yard = Yard.new()
  @yard.title = yard_params[:title]
  @yard.description = yard_params[:description]
  @yard.city = yard_params[:city].to_i
  @yard.zipcode = yard_params[:zipcode]
  @yard.kid_and_pet_friendly = yard_params[:kid_and_pet_friendly]
  @yard.fire_friendly = yard_params[:fire_friendly]
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
  end
  @yard = Yard.find_by_id(params[:id])
  @comments = Comment.where(yard_id: @yard.id.to_s)
end

def destroy
  @yard = Yard.find_by_id(params[:id])
  if @yard.destroy
    flash[:error] = @yard.title + 'was deleted, never to be seen again..'
    redirect_to :back
  else
    flash[:error] = "try deleting again, something went wrong"
  end
end

def edit
  @yard = Yard.find_by_id(params[:id])
end

def update
  @curr_user = User.find_by_id(current_user.id.to_s)
  @yard = Yard.find_by_id(params[:id])
  if @yard.update(yard_params)
    redirect_to user_path_url(@curr_user)
  else
    flash[:error] = @yard.errors.full_messages
    redirect_to :back
  end
end

def cities
  @yards = Yard.where(city: params[:city])
  @city = params[:city]
  weather_hash = fetch_weather params[:city]
  assign_values(weather_hash)
end

private

def yard_params
  params.require(:yard).permit(:title, :description, :kid_and_pet_friendly, :fire_friendly, :zipcode, :city, :safety)
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
    elsif city == 'santa_barabara'
      zipcode = 93101
    elsif city == 'sonoma'
      zipcode = 95476
    elsif city == 'los_angeles'
      zipcode = 90001
    end
   @response = HTTParty.get("http://api.openweathermap.org/data/2.5/forecast/daily?zip=#{zipcode}&cnt=10&APPID=56816b6400cf26a5068b34d20251372f")
 end


  def assign_values(weather_hash)
         @forecast_response = weather_hash.parsed_response['city']
   end

end
