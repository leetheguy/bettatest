class SendContactMailer < ActionMailer::Base
  default :from => "anonymous user"

  def send_contact(user, subject, content)
    @user = user
    mail(:to => "lee@bettatest.com", :subject => subject)
  end

end
