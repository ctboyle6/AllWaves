require 'sendgrid-ruby'
include SendGrid

class UserNotifierMailer < ApplicationMailer
  # default :from => 'allwavesproject@gmail.com'
  
  def update_conditions(user,user_spot)
    from = Email.new(email: 'allwavesproject@gmail.com')
    to = Email.new(email: user.email)
    subject = 'Conditions have been updated !'
    content = Content.new(type: 'text/plain', value: '🔥🔥🔥')
    mail = SendGrid::Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end

end
