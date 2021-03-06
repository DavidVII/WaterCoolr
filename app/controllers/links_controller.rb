class LinksController < ApplicationController
  before_filter :authenticate_user!, except: :show
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def show
    @link = Link.find(params[:id])
    @comment = Comment.new
    @comments = @link.comments.order('created_at DESC')
  end

  def new
    @link = Link.new
  end

  def create
    @link = current_user.links.create(link_params)

    if @link.save
      flash[:success] = "Your link has been submitted!"
      redirect_to @link
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @link.update_attributes(link_params)
      flash[:success] = "Your link has been updated"
      redirect_to link_path(@link)
    else
      render 'edit'
    end
  end

  def destroy
    @link.destroy
    flash[:notice] = "Your link has been deleted"
    redirect_to root_path
  end

  private

    def link_params
      params.require(:link).permit(:title, :url, :user_id)
    end

    def correct_user
      @link = current_user.links.find_by_id(params[:id])
      if @link.nil?
        flash[:error] = "You're not allowed to do that"
        redirect_to root_path
      end
    end
end
