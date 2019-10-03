require 'set'

module Operations
  class PlayGroupMatches

    def initialize(group:)
      @group = group
    end

    def call()
      ActiveRecord::Base.transaction do
        build_team_pairs
        play_matches
        close_group
      end
    end

    private

    def build_team_pairs
      @team_pairs = []

      @group.teams.each do |team_1|
        @group.teams.each do |team_2|
          unless team_1 == team_2
            @team_pairs << Set[team_1, team_2]
          end
        end
      end

      @team_pairs = @team_pairs.shuffle.uniq
    end

    def play_matches
      @team_pairs.each do |team_pair|
        team_1, team_2 = team_pair.to_a
        play_match(team_1: team_1, team_2: team_2)
      end
    end

    def play_match(team_1:, team_2:)
      match_result = Operations::PlayMatch.new(
          team_1: team_1,
          team_2: team_2
      ).call

      match = Match.create!(
        team_1_id: team_1.id,
        team_2_id: team_2.id,
        team_1_score: match_result.team_1_score,
        team_2_score: match_result.team_2_score,
        group_id: @group.id,
        tournament_id: @group.tournament_id,
      )

      goals = match_result.goals.each do |goal|
        goal[:match_id] = match.id
        Goal.create!(goal)
      end
    end

    def close_group
      @group.play_out
      @group.save!
    end
  end
end