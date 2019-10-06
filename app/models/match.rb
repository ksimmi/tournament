class Match < ApplicationRecord
  has_many :goals
  belongs_to :tournament
  belongs_to :group
  belongs_to :team_1, class_name: 'Team', foreign_key: :team_1_id
  belongs_to :team_2, class_name: 'Team', foreign_key: :team_2_id

  def teams
    @teams ||= Team.where('id in (?, ?)', team_1, team_2).to_a
  end

  def winner?(team)
    team.id == winner_id
  end

  def draw?
    winner_id.nil?
  end

  def winner_id
    if team_1_score > team_2_score
      return team_1_id
    end

    if team_2_score > team_1_score
      return team_2_id
    end

    nil
  end
end
