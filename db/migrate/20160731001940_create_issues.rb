class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :severity
      t.string :source
      t.string :description
      t.text :detail
      t.string :fingerprint
      t.references :scan, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
