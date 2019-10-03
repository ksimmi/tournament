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

  def show_scores
    group = Group.find(params[:id])
    matches = group.matches.order('id asc').to_a

    unless group.played_out?
      raise ActionController::RoutingError.new('Not Found')
    end

    render locals: { group: group, matches: matches }
  end
end
