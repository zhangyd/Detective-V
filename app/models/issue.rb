class Issue < ActiveRecord::Base
  belongs_to :scan
  belongs_to :repo
  validates :repo_id, presence: true
end
