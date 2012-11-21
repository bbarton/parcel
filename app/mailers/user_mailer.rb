class UserMailer < ActionMailer::Base
  default from: "hello@parcel.com"

  def message_email(message)
    @message = message
    @garden = message.garden
    @recipient = message.recipient
    mail(to: @recipient.email, subject: "Someone is interested in your parcel!")
  end
end
