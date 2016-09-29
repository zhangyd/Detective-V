class RemoveFullNameFromRepos < ActiveRecord::Migration
  def change
    remove_column :repos, :full_name, :string
  end
end
