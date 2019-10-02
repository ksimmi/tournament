class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
  end

  def show
    tournament = Tournament.find_by(id: params.fetch(:id))
    divisions = tournament.groups.where(type: 'Group::Division')

    render locals: {
      tournament: tournament,
      divisions: divisions
    }
  end
end
