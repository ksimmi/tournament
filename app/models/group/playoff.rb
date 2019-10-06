class Group
  class Playoff < Group

    DIVISION_MATCHES_INNER_JOIN = <<~SQL
      INNER JOIN groups
         ON groups.id = matches.group_id
        AND groups.type = 'Group::Division'
    SQL

    def matches_for_rank_calculation
      @division_matches ||= Match
          .joins(DIVISION_MATCHES_INNER_JOIN)
          .where(tournament_id: tournament.id)
          .to_a
    end

    def won_teams
      @won_teams ||= teams.where(id: matches.map(&:winner_id))
    end
  end
end