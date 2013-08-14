class LinksController < ApplicationController
  before_filter :authenticate_user!, except: :show
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def show
    @link = Link.find(params[:id])
    @comment = Comment.new
    @comments = @link.comments.order('created_at DESC')
    @vote = current_user.votes.find_by(link_id: params[:id])
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
      # FIXME: Temporary solution while working on links#edit
      flash[:error] = "Error: #{@link.errors.full_messages}"
      redirect_to :back
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
      redirect_to root_path if @link.nil?
    end
end
