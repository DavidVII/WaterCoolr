class VotesController < ApplicationController
  def create
    # @vote = current_user.votes.create(vote_params)
    @vote = current_user.votes.where(link_id: vote_params[:link_id]).first || current_user.votes.create(vote_params)
    @vote.update_attributes(up: vote_params[:up])

    flash[:notice] = @vote.errors.inspect

    redirect_to :back
  end

  private

    def vote_params
      params.require(:vote).permit(:user_id, :link_id, :up)
    end
end
