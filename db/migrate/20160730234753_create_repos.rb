class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name
      t.string :owner
      t.string :full_name
      t.string :html_url
      t.string :description
      t.string :language
      t.integer :size

      t.timestamps null: false
    end
  end
end
