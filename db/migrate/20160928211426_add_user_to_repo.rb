class AddUserToRepo < ActiveRecord::Migration
  def change
    add_reference :repos, :user, index: true, foreign_key: true
  end
end
