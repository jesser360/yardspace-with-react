class YardsController < ApplicationController

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
  @yard = Yard.find_by_id(params[:id])
  @curr_user = User.find_by_id(current_user.id.to_s)
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


private

def yard_params
  params.require(:yard).permit(:title, :description, :kid_and_pet_friendly, :fire_friendly, :zipcode, :city, :safety)
end

end
