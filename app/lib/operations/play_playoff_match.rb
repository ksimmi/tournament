module Operations
  class PlayPlayoffMatch < PlayDivisionMatch

    def build_goals
      super()
      play_penalties if is_draw?
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
  end
end