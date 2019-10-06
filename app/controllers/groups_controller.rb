class GroupsController < ApplicationController
  def play_matches
    group = Group.find(params[:id])

    unless group.played_out?
      if group.is_a?(Group::Division)
        ::Operations::PlayDivisionMatches.new(group: group).call
      end

      if group.is_a?(Group::Playoff)
        ::Operations::IterateOverPlayoffStages.new(group: group).call
      end
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
