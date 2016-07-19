class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :repo_name
      t.string :url

      t.timestamps null: false
    end
  end
end
