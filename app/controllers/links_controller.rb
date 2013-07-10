class LinksController < ApplicationController
  def show

  end

  def new
    @link = Link.new    
  end

  def create
    @link = Link.create(user_params)
    if @link.save
      flash[:success] = "Your link has been submitted!"
      render 'show'
    else
      flash[:notice] = "Sorry, no goose..."
      render 'new'
    end
  end

  def user_params
    params.require(:link).permit(:title, :url)
  end
end
