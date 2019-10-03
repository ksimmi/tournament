class AddStatusToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :status, :string, default: 'new'
  end
end
