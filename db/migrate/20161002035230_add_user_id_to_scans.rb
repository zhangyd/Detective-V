class AddUserIdToScans < ActiveRecord::Migration
  def change
    add_column :scans, :user_id, :integer
  end
end
