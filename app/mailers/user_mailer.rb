class UserMailer < ActionMailer::Base
  default :from => "bettatest.com"
  
  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "bettatest.com registration confirmation")

  end
end
