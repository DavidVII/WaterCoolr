class VotesController < ApplicationController
  def create
    if current_user.present?
      @vote = current_user.votes.where(link_id: vote_params[:link_id]).first || current_user.votes.create(vote_params)
      @vote.update_attributes(up: vote_params[:up])
      redirect_to :back
    else
      redirect_to new_user_session_path
      flash[:notice] = "You must be signed in to vote"
    end
  end

  private

    def vote_params
      params.require(:vote).permit(:user_id, :link_id, :up)
    end
end
