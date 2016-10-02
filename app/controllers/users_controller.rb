class UsersController < ApplicationController
	def settings
		@user = current_user
		# should be error checking for correct length
		if request.post?
			@user.access_token = params[:user][:access_token]
			@user.save
		end

	end

end
