ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "bettatest.com",
  :user_name            => "gil@bettatest.com",
  :password             => "1@mYourGramma",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "bettatest.com"
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
