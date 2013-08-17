class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.create(comment_params)

    if @comment.save
      flash[:success] = "Your comment has been added!"
    else
      flash[:error] = @comment.errors.full_messages.to_sentence
    end

   redirect_to :back 
  end

  def edit
  end

  def update
    link = @comment.link

    if @comment.update_attributes(comment_params)
      flash[:success] = "Your comment has been updated"
      redirect_to link_path(link)
    else
      render 'edit'
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
      if @comment.nil?
        flash[:error] = "You're not allowed to do that"
        redirect_to root_path
      end
    end

end
