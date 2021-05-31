require 'twilio-ruby'


def send_sms_notification(user, user_spot)

  account_sid = ENV['TWILIO_ACCOUNT_SID']
  auth_token = ENV['TWILIO_AUTH_TOKEN']
  client = Twilio::REST::Client.new(account_sid, auth_token)


  from = '+19728290975' # Your Twilio number
  to = user.phone_number # Your mobile phone number

  client.messages.create(
  from: from,
  to: to,
  body: "#{user_spot.spot.name.capitalize} has been updated - Check the app to look at it ! 🏄"
  )

end
