class CallbacksController < Devise::OmniauthCallbacksController
  # def github
  # 	# auth = request.env["omniauth.auth"]
  #   # @user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)    
  #   @user = User.from_omniauth(request.env["omniauth.auth"])
  #   sign_in_and_redirect @user
  # end

  def github
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = "Signed in Through Github!"
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      # flash.notice = "You are almost Done! Please provide a password to finish setting up your account"
      redirect_to root_url
    end
  end
end