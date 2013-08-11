class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user, only: :destroy

  def create
    @comment = current_user.comments.create(comment_params)

    if @comment.save
      flash[:success] = "Your comment has been added!"
    else
      flash[:notice] = "Your comment was not added :("
    end

   redirect_to :back 
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Your comment has been deleted"
    redirect_to :back
  end

  private

    def comment_params
      params.require(:comment).permit(:message, :link_id)
    end

    def correct_user
      @comment = current_user.comments.find_by_id(params[:id])
      redirect_to root_path if @comment.nil?
    end

end
