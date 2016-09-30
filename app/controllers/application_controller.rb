class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_repos

  # method to check users first

	def get_repos
		unless current_user.nil?
			@repos = current_user.repos
		end
	end
end
