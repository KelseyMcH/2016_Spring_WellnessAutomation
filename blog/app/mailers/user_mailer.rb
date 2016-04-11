class UserMailer < ApplicationMailer
	default from: "wellnessadmin@wellnessautomation.herokuapp.com"



	 def password_reset(user)
      @user = user
      @pwdlink = "wellnessautomation.herokuapp.com/password_resets/"+ @user.reset_password_token + "/edit?email=" + @user.email
      mail to: user.email, subject: "Password reset"
  	end
	
	def registration_confirmation(user)
		@user = user
		@link = "wellnessautomation.herokuapp.com/welcome/confirm_email?confirm_token=" + @user.confirm_token 
		mail(to:@user.email, subject: 'Welcome to LifeCare Wellness!')
	end
end
