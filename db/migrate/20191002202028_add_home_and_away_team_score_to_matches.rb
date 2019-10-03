class AddHomeAndAwayTeamScoreToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :home_team_score, :integer
    add_column :matches, :away_team_score, :integer

    add_foreign_key :matches, :teams , column: :home_team_score
    add_foreign_key :matches, :teams , column: :away_team_score
  end
end
