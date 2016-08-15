class AddRepotoIssue < ActiveRecord::Migration
  def change
  	add_reference :issues, :repo, index: true
  end
end
