class LinksController < ApplicationController
  before_filter :authenticate_user!

  def show
    @link = Link.find(params[:id])
    @comment = Comment.new
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
      flash[:notice] = "Sorry, no goose..."
      render 'new'
    end
  end

  def link_params
    params.require(:link).permit(:title, :url, :user_id)
  end
end
