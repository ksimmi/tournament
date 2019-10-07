class Tournament < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :matches, dependent: :destroy
  has_and_belongs_to_many :teams

  TOURNAMENT_TEAMS_COUNT = 16

  validates :title, presence: true
  validate :team_count_is_not_valid

  after_initialize :teams_for_validation

  def teams_for_validation
    @teams_for_validation = teams
  end

  def teams=(value)
    @teams_for_validation = value
    super(value)
  end

  def team_count_is_not_valid
    unless @teams_for_validation.count == TOURNAMENT_TEAMS_COUNT
      errors.add(:team_count_is_not_valid, "Team's count must be #{TOURNAMENT_TEAMS_COUNT}. Your count is #{@teams_for_validation.count}")
    end
  end
end
