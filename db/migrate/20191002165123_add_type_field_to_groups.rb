class AddTypeFieldToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :type, :string
  end
end
