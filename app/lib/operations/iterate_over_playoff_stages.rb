require 'set'

module Operations
  class IterateOverPlayoffStages

    def initialize(group:)
      @playoff_stage = group
    end

    def call
      iterate_over_stages
    end

    private

    def iterate_over_stages
      run_current_iteration
      run_next_iteration
    end

    def run_current_iteration
      Operations::PlayPlayoffMatches.new(group: @playoff_stage).call
    end

    def run_next_iteration
      if @playoff_stage.won_teams.many?
        group = create_next_playoff_stage
        Operations::IterateOverPlayoffStages.new(group: group).call
      end
    end


    def create_next_playoff_stage
      if @playoff_stage.won_teams.count == 2
        title = 'Final'
      else
        title = "Playoff (1/#{(@playoff_stage.won_teams.count / 2).to_i})"
      end

      Group::Playoff.create(
        title: title,
        tournament: @playoff_stage.tournament,
        teams: @playoff_stage.won_teams
      )
    end
  end
end