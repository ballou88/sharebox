ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "codeaxioms.com",
  :user_name            => "sharebox@codeaxioms.com",
  :password             => "Pazzw0rd?",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
