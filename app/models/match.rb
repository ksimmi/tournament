class Match < ApplicationRecord
  has_many :goals
  belongs_to :tournament
  belongs_to :group
  belongs_to :home_team, class_name: 'Team', foreign_key: :home_team_id
  belongs_to :away_team, class_name: 'Team', foreign_key: :away_team_id

  def is_draw?
    if new_record?
      return home_team_goals_count == away_team_goals_count
    end
    home_team_score == away_team_score
  end

  def home_team_goals_count
    goals.select { |g| g.team == home_team }.count
  end

  def away_team_goals_count
    goals.select { |g| g.team == away_team }.count
  end
end
