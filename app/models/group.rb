class Group < ApplicationRecord
  has_many :matches
  has_and_belongs_to_many :teams
  belongs_to :tournament

  STATUS_PLAYED_OUT = 'played_out'

  def played_out?
    status == STATUS_PLAYED_OUT
  end

  def play_out
    self[:status] = STATUS_PLAYED_OUT
  end

  def team_ranks
    @ranks ||= teams.map do |team|
      {
          team_id: team.id,
          rank_value: home_winners[team.id] + away_winners[team.id]
      }
    end
  end

  def home_winners
    matches.where('home_team_score > away_team_score').group(:home_team_id).count
  end

  def away_winners
    matches.where('away_team_score > home_team_score').group(:away_team_id).count
  end
end
