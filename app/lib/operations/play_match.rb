module Operations
  class PlayMatch

    RANGE_OF_POSSIBLE_GOALS_FOR_MAIN_TIME = (0..7)
    RANGE_OF_POSSIBLE_GOALS_FOR_EXTRA_TIME = (0..3)
    RANGE_OF_POSSIBLE_GOALS_FOR_PENALTY_ROUND = (0..5)

    attr_reader :goals

    def initialize(team_1:, team_2:)
      @team_1 = team_1
      @team_2 = team_2
      @goals = []
    end

    def call()
      build_goals
      self
    end

    def team_1_score
      @goals.select { |goal| goal[:team_id] == @team_1.id }.count
    end

    def team_2_score
      @goals.select { |goal| goal[:team_id] == @team_2.id }.count
    end

    private

    def build_goals
      play_main_time
      play_extra_time if is_draw?
      play_penalties if is_draw?
    end

    def is_draw?
      team_1_score == team_2_score
    end

    def play_main_time
      randomize_goals(
          goal_range: RANGE_OF_POSSIBLE_GOALS_FOR_MAIN_TIME,
          goal_kind: 'goal'
      )
    end

    def play_extra_time
      randomize_goals(
          goal_range: RANGE_OF_POSSIBLE_GOALS_FOR_EXTRA_TIME,
          goal_kind: 'goal'
      )
    end

    def play_penalties
      randomize_goals(
          goal_range: RANGE_OF_POSSIBLE_GOALS_FOR_PENALTY_ROUND,
          goal_kind: 'penalty'
      )

      await_winner
    end

    def await_winner
      while is_draw?
        randomize_goals(
            goal_range: (0..1),
            goal_kind: 'penalty'
        )
      end
    end

    def randomize_goals(goal_range:, goal_kind:)
      team_1_goals_count = rand(goal_range)
      team_2_goals_count = rand(goal_range)

      team_1_goals_count.times do
        @goals << {
          team_id: @team_1.id,
          kind: goal_kind
        }
      end

      team_2_goals_count.times do
        @goals << {
          team_id: @team_2.id,
          kind: goal_kind
        }
      end
    end
  end
end