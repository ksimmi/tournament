require 'set'

module Operations
  class PlayPlayoffMatches < PlayDivisionMatches

    private

    def build_team_pairs
      @team_pairs = []
      team_list = @group.teams_with_ranks.to_a.sort_by { |t| t.rank * -1 }

      while team_list.any?
        strong_team, *team_list, weak_team = team_list
        @team_pairs << [strong_team, weak_team]
      end
    end
  end
end