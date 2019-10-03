class Match < ApplicationRecord
  has_many :goals
  belongs_to :tournament
  belongs_to :group
  belongs_to :home_team, class_name: 'Team', foreign_key: :home_team_id
  belongs_to :away_team, class_name: 'Team', foreign_key: :away_team_id
end
