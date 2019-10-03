class Group < ApplicationRecord
  has_many :matches
  has_and_belongs_to_many :teams
  belongs_to :tournament

  STATUS_PLAYED_OUT = 'played_out'

  POINTS_FOR_WIN = 3
  POINTS_FOR_DRAW = 1
  POINTS_FOR_LOSS = 0

  def played_out?
    status == STATUS_PLAYED_OUT
  end

  def play_out
    self[:status] = STATUS_PLAYED_OUT
  end

  def team_ranks
    return @ranks if @ranks

    @ranks = {}
    teams.each do |team|
      @ranks[team.id] ||= 0

      matches.each do |match|
        if match.winner?(team)
          @ranks[team.id] += POINTS_FOR_WIN
        end

        if match.draw?
          @ranks[team.id] += POINTS_FOR_DRAW
        end
      end
    end
    @ranks
  end
end
