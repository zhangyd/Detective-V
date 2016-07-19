class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :repository_id
      t.string :name
      t.string :severity
      t.string :description
      t.string :reference_url
      t.string :dependency

      t.timestamps null: false
    end
  end
end
