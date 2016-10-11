class Scan < ActiveRecord::Base
  belongs_to :repo
  belongs_to :user
  has_many :issues, dependent: :destroy
  validates :repo_id, presence: true
end
