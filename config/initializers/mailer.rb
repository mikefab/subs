	ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
:enable_starttls_auto => true,
:address => 'smtp.gmail.com',
:port => 587,
:domain => "caps.heroku.com",
:user_name => 'mikefabrikant@gmail.com',
:password => 'Riddler2',
:authentication => 'plain',
}
