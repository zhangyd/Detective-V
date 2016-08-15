class AddLineToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :line, :string
  end
end
