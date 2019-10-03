class MakeAllEntities < ActiveRecord::Migration[5.2]

  def change
    create_table :tournaments do |t|
      t.string :title
      t.timestamps
    end

    create_table :teams do |t|
      t.string :name
      t.timestamps
    end

    create_table :groups do |t|
      t.integer :tournament_id, index: true, null: false
      t.string :title
      t.string :status, default: 'new'
      t.string :type, index: true, null: false
      t.timestamps
    end

    create_table :matches do |t|
      t.integer :tournament_id, index: true, null: false
      t.integer :group_id, index: true, null: false
      t.integer :team_1_id, index: true
      t.integer :team_2_id, index: true
      t.integer :team_1_score
      t.integer :team_2_score

      t.timestamps
    end

    create_table :goals do |t|
      t.integer :match_id, index: true, null: false
      t.integer :team_id, index: true, null: false
      t.string  :kind, index: true, null: false, default: 'goal'
      t.timestamps
    end

    create_table :teams_tournaments do |t|
      t.integer :tournament_id, index: true, null: false
      t.integer :team_id, index: true, null: false
    end

    create_table :groups_teams do |t|
      t.integer :group_id, index: true, null: false
      t.integer :team_id, index: true, null: false
    end

    add_foreign_key :groups, :tournaments , column: :tournament_id, on_delete: :cascade
    add_foreign_key :matches, :tournaments , column: :tournament_id, on_delete: :cascade
    add_foreign_key :matches, :groups , column: :group_id, on_delete: :cascade
    add_foreign_key :matches, :teams , column: :team_1_id, on_delete: :cascade
    add_foreign_key :matches, :teams , column: :team_2_id, on_delete: :cascade
    add_foreign_key :matches, :teams , column: :team_1_score
    add_foreign_key :matches, :teams , column: :team_2_score

    add_foreign_key :goals, :matches , column: :match_id, on_delete: :cascade
    add_foreign_key :goals, :teams , column: :team_id, on_delete: :cascade

    add_foreign_key :tournaments_teams, :tournaments , column: :tournament_id, on_delete: :cascade
    add_foreign_key :tournaments_teams, :teams , column: :team_id, on_delete: :cascade
    add_foreign_key :groups_teams, :groups , column: :group_id, on_delete: :cascade
    add_foreign_key :groups_teams, :teams , column: :team_id, on_delete: :cascade
  end
end
