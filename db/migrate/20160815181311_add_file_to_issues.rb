class AddFileToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :file, :string
  end
end
