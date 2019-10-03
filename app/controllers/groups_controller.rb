class GroupsController < ApplicationController
  def play_matches
    group = Group.find(params[:id])

    unless group.played_out?
      ::Operations::PlayGroupMatches.new(
          group: group
      ).call
    end

    redirect_to tournament_path(id: group.tournament_id)
  end
end
