class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @comment = current_user.comments.create(comment_params)

    if @comment.save
      flash[:success] = "Your comment has been added!"
    else
      flash[:notice] = "Your comment was not added :("
    end

   redirect_to :back 
  end

  private

    def comment_params
      params.require(:comment).permit(:message, :link_id)
    end

end
