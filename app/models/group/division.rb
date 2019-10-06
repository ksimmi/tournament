class Group
  class Division < Group
    DIVISION_TEAMS_COUNT = 8

    def teams_for_playoff
      sorted_teams_by_rank = teams_with_ranks.to_a.sort_by { |t| t.rank * -1 }
      sorted_teams_by_rank.take(TEAMS_FOR_PLAYOFF_COUNT)
    end

    def matches_for_rank_calculation
      return @division_matches if @division_matches
      team_ids = teams.map(&:id)
      @division_matches = matches.to_a.select do |m|
        [m.team_1_id, m.team_2_id].any? { |tid| team_ids.include?(tid) }
      end
    end
  end
end