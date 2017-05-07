class CommentsController < ActionController::Base

  def destroy
    @curr_user = User.find_by_id(session[:user_id])
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy
    redirect_to :back
  end

  def create
    puts "WERE IN CREATE COMMMENTS"
    puts comment_params[:title]
    puts comment_params[:body]
    puts comment_params[:yard_id]
    @curr_user = User.find_by_id(session[:user_id])
    @user= User.find_by_id(session[:user_id])
    @comment= Comment.new(comment_params)
    @comment.user = @user
    @comment.save
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body, :yard_id)
  end

end
