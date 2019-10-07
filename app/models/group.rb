class Group < ApplicationRecord
  has_many :matches, dependent: :destroy
  has_and_belongs_to_many :teams
  belongs_to :tournament

  STATUS_PLAYED_OUT = 'played_out'

  POINTS_FOR_WIN = 3
  POINTS_FOR_DRAW = 1
  POINTS_FOR_LOSS = 0

  TEAMS_FOR_PLAYOFF_COUNT = 4

  def played_out?
    status == STATUS_PLAYED_OUT
  end

  def play_out
    self[:status] = STATUS_PLAYED_OUT
  end

  def matches_for_rank_calculation
    []
  end

  def teams_with_ranks
    return @teams_with_ranks if @teams_with_ranks

    @teams_with_ranks = teams.to_a
    @teams_with_ranks.each do |team|
      team.rank ||= 0

      matches_for_rank_calculation.each do |match|
        unless [match.team_1_id, match.team_2_id].include?(team.id)
          next
        end

        if match.winner?(team)
          team.rank += POINTS_FOR_WIN
        end

        if match.draw?
          team.rank += POINTS_FOR_DRAW
        end
      end
    end
  end
end
