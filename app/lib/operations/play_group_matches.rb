module Operations
  class PlayGroupMatches

    def initialize(group:)
      @group = group
    end

    def call()
      ActiveRecord::Base.transaction do
        build_match_compositions
        play_matches
        close_group
      end
    end

    private

    def build_match_compositions
      @matches = []
      @group.teams.each do |home_team|
        @group.teams.each do |away_team|
          unless home_team == away_team
            @matches << Match.new(
                home_team: home_team,
                away_team: away_team,
                group: @group
            )
          end
        end
      end
    end

    def play_matches
      @matches.each do |match|
        Operations::PlayGroupMatch.new(match: match).call
        record_match_result(match)
      end
    end

    def record_match_result(match)
      match.home_team_score = match.home_team_goals_count
      match.away_team_score = match.away_team_goals_count
      match.tournament = @group.tournament
      match.save!
    end

    def close_group
      @group.play_out
      @group.save!
    end
  end
end