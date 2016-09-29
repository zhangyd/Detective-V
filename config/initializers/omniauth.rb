Rails.application.config.middleware.use OmniAuth::Builder do
	provider :github, Settings.github['GITHUB_KEY'], Settings.github['GITHUB_SECRET'], scope: 'user:email'
end