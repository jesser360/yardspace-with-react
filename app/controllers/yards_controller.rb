class YardsController < ApplicationController

def new
  @yard = Yard.new
end

def create
  @curr_user = User.find_by_id(current_user.id.to_s)
  @yard = Yard.new(yard_params)
  @yard.user = @curr_user
  if @yard.save
    redirect_to user_path_url(@curr_user)
  else
    flash[:error] = @yard.errors.full_messages.join(", ")
    redirect_to :back
  end
end


private

def yard_params
  params.require(:yard).permit(:title, :description, :kid_and_pet_friendly, :fire_friendly, :zipcode, :city, :safety)
end

end
