module Operations
  class PlayGroupMatches

    def initialize(group:)
      @group = group
    end

    def call()
      ActiveRecord::Base.transaction do
        play_matches
        close_group
      end
    end

    private

    def play_matches
      @matches = []
      @goals = []
      @group.teams.each do |home_team|
        @group.teams.each do |away_team|
          unless home_team == away_team
            play_match(team_1: home_team, team_2: away_team)
          end
        end
      end
    end

    def play_match(team_1:, team_2:)
      match_result = Operations::PlayMatch.new(
          team_1: team_1,
          team_2: team_2
      ).call

      match = Match.create(
        home_team_id: team_1.id,
        away_team_id: team_2.id,
        home_team_score: match_result.team_1_score,
        away_team_score: match_result.team_2_score,
        group_id: @group.id,
        tournament_id: @group.tournament_id,
      )

      goals = match_result.goals.each do |goal|
        goal[:match_id] = match.id
        Goal.create(goal)
      end
    end

    def close_group
      @group.play_out
      @group.save!
    end
  end
end