require "net/http"

class Repo < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true
	validates :html_url, presence: true
	has_many :scans, dependent: :destroy
	has_many :issues, dependent: :destroy

	def self.get_repo url
		# first check url exists
		parsed_url = url.split('/')
		full_name = parsed_url[-2] + "/" + parsed_url[-1]
		params = {}
		url = URI.parse("https://api.github.com/repos/" + full_name)
		req = Net::HTTP.new(url.host, url.port)
		req.use_ssl = true
		res = req.request_head(url.path)

		if res.code == "200"
			github = ApplicationHelper.github
			git_repo = github.repo(full_name)
			params = {
				name: parsed_url[-1], 
				owner: parsed_url[-2],
				html_url: git_repo[:html_url],
				description: git_repo[:description],
				language: git_repo[:language],
				size: git_repo[:size],
				user_id: -1
			}
			return params
		end
	end
end