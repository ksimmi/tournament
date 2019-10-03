module Operations
  class PlayGroupMatch

    RANGE_OF_POSSIBLE_GOALS_FOR_MAIN_TIME = (0..7)
    RANGE_OF_POSSIBLE_GOALS_FOR_EXTRA_TIME = (0..3)
    RANGE_OF_POSSIBLE_GOALS_FOR_PENALTY_ROUND = (0..5)

    attr_reader :goals

    def initialize(match:)
      @match = match
      @goals = []
    end

    def call()
      play_match
    end

    private

    def play_match
      play_main_time

      if @match.is_draw?
        play_extra_time
      end

      if @match.is_draw?
        play_penalties
      end
    end

    def play_main_time
      @match.goals = randomize_goals(
          goal_range: RANGE_OF_POSSIBLE_GOALS_FOR_MAIN_TIME,
          goal_kind: 'goal'
      )
    end

    def play_extra_time
      @match.goals = randomize_goals(
          goal_range: RANGE_OF_POSSIBLE_GOALS_FOR_EXTRA_TIME,
          goal_kind: 'goal'
      )
    end

    def play_penalties
      @match.goals = randomize_goals(
          goal_range: RANGE_OF_POSSIBLE_GOALS_FOR_PENALTY_ROUND,
          goal_kind: 'penalty'
      )

      await_winner
    end

    def await_winner
      while @match.is_draw?
        @match.goals = randomize_goals(
            goal_range: (0..1),
            goal_kind: 'penalty'
        )
      end
    end

    def randomize_goals(goal_range:, goal_kind:)
      home_goals_count = rand(goal_range)
      away_goals_count = rand(goal_range)

      home_goals_count.times do
        @goals << ::Goal.new(
            match: @match,
            team: @match.home_team,
            kind: goal_kind
        )
      end

      away_goals_count.times do
        @goals << ::Goal.new(
            match: @match,
            team: @match.away_team,
            kind: goal_kind
        )
      end

      @goals
    end
  end
end