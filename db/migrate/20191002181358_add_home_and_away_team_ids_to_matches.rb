class AddHomeAndAwayTeamIdsToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :home_team_id, :integer
    add_column :matches, :away_team_id, :integer

    add_foreign_key :matches, :teams , column: :home_team_id, on_delete: :cascade
    add_foreign_key :matches, :teams , column: :away_team_id, on_delete: :cascade
  end
end
