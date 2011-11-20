class TesterStatSheetMailer < ActionMailer::Base
  default :from => "bettatest.com"

  def activation_notice(tss)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "bettatest.com registration confirmation")
  end
end
