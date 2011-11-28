class UserMailer < ActionMailer::Base
  default :from => "no-repyly@bettatest.com"

  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "bettatest.com registration confirmation")
  end

  def activation_notice(tester_stat_sheet)
    @beta_test = tester_stat_sheet.beta_test
    user = tester_stat_sheet.user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "bettatest.com you're invited to a test")
  end
end
