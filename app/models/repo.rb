require "net/http"

class Repo < ActiveRecord::Base
	validates :name, presence: true
	validates :owner, presence: true
	has_many :scans, dependent: :destroy
	has_many :issues, dependent: :destroy

	def self.get_repo name, owner
		# first check url exists
		full_name = owner + "/" + name
		params = {}
		url = URI.parse("https://api.github.com/repos/" + full_name)
		req = Net::HTTP.new(url.host, url.port)
		req.use_ssl = true
		res = req.request_head(url.path)

		if res.code == "200"

			github = ApplicationHelper.github
			git_repo = github.repo(full_name)
			params = {
				name: name, 
				owner: owner,
				html_url: git_repo[:html_url],
				description: git_repo[:description],
				language: git_repo[:language],
				size: git_repo[:size]
			}
			return params
		end
	end
end