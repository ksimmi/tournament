class Tournament < ApplicationRecord
  has_many :groups
  has_many :matches
  has_and_belongs_to_many :teams

  TOURNAMENT_TEAMS_COUNT = 16



  validates :title, presence: true
  validate :team_count_is_not_valid

  def team_count_is_not_valid
    unless teams.count == TOURNAMENT_TEAMS_COUNT
      errors.add(:team_count_is_not_valid, "Team's count must be #{TOURNAMENT_TEAMS_COUNT}. Your count is #{teams.count}")
    end
  end
end
