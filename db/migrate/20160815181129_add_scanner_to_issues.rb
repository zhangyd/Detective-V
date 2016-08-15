class AddScannerToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :scanner, :string
  end
end
