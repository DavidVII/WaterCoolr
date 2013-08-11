class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.create(comment_params)

    if @comment.save
      flash[:success] = "Your comment has been added!"
    else
      flash[:notice] = "Your comment was not added :("
    end

   redirect_to :back 
  end

  def edit
  end

  def update
    if @comment.update_attributes(params[:message])
      flash[:success] = "Your comment has been updated"
      redirect_to :back
    else
      flash[:error] = "Something went wrong"
      redirect_to :back
    end
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
