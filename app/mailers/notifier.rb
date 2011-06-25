# app/mailer/notifier.rb
class Notifier < ActionMailer::Base

  def support_notification(sender)
    @sender = sender
    mail(:to => "mikefabrikant@gmail.com",
         :from => sender.email,
         :subject => "AudioVerb message")
 end
end
