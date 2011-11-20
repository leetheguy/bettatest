class SiteMailer < ActionMailer::Base

  def send_contact(from, subject, content)
    @from = from
    @subject = subject
    @content = content
    mail(:to => "lee@bettatest.com", :subject => subject, :from => from, :reply_to => from)
  end

end
