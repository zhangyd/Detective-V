class UsersController < ApplicationController
	def settings
		@user = current_user
		# should be error checking for correct length
		if request.post?
			@user.access_token = params[:user][:access_token]
			if @user.save
				redirect_to :back, notice: "Access Token Saved!"
			else
				redirect_to :back, notice: "Error!"
			end
		end
	end
end
