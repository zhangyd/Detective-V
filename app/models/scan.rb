class Scan < ActiveRecord::Base
  belongs_to :repo
  has_many :issues, dependent: :destroy
  validates :repo_id, presence: true
end
