class UserMailer < ApplicationMailer
	default from: "wellnessadmin@wellnessautomation.herokuapp.com"



	def reset_password_email(user)

	end
	
	def welcome_email(user,pwd)
		@user = user
		@pwd = pwd
		@url = 'http://wellnessautomation.herokaupp.com/login'
		mail(to:@user.email, subject: 'Welcome to LifeCare Wellness!')
	end
end
