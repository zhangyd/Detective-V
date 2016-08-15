class AddCodeToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :code, :string
  end
end
