class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
  end

  def show
    get_tournament
    get_divisions
    get_playoff

    render locals: {
      tournament: @tournament,
      divisions: @divisions,
      playoff: @playoff
    }
  end

  private

  def get_tournament
    @tournament = Tournament.find_by(id: params.fetch(:id))
  end

  def get_divisions
    @divisions = @tournament.groups.where(type: 'Group::Division').to_a
    create_divisions unless @divisions.any?
  end

  def create_divisions
    ActiveRecord::Base.transaction do
      division_a_teams, division_b_teams = @tournament.teams.each_slice(Group::Division::DIVISION_TEAMS_COUNT).to_a

      division_a = Group::Division.create(
          title: 'Division A',
          tournament: @tournament,
          teams: division_a_teams,
          )

      division_b = Group::Division.create(
          title: 'Division B',
          tournament: @tournament,
          teams: division_b_teams
      )

      @divisions << division_a
      @divisions << division_b
    end
  end

  def get_playoff
    if @divisions.all? { |d| d.played_out? }
      @playoff = @tournament.groups.where(type: 'Group::Playoff')
      create_playoff unless @playoff.any?
    end
  end

  def create_playoff
    playoff_teams = @divisions.map(&:teams_for_playoff).flatten
    title = "Playoff (1/#{(playoff_teams.count / 2).to_i})"
    @playoff = [Group::Playoff.create(
        title: title,
        tournament: @tournament,
        teams: playoff_teams
    )]
  end
end
