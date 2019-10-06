class Group
  class Division < Group
    DIVISION_TEAMS_COUNT = 8

    def teams_for_playoff
      sorted_teams_by_rank = teams_with_ranks.to_a.sort_by { |t| t.rank * -1 }
      sorted_teams_by_rank.take(TEAMS_FOR_PLAYOFF_COUNT)
    end

    def matches_for_rank_calculation
      division_matches = matches.to_a
    end


  end
end