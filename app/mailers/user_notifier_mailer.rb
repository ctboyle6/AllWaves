require 'sendgrid-ruby'
include SendGrid

class UserNotifierMailer < ApplicationMailer
  # default :from => 'allwavesproject@gmail.com'
  
  def update_conditions(user,user_spot)
    from = Email.new(email: 'allwavesproject@gmail.com')
    to = Email.new(email: user.email)
    subject = "#{user_spot.name.capitalize} conditions have been updated !"
    content = Content.new(type: 'text/html', value: "
      #{user_spot.name.capitalize} received new conditions :
      <br/>
      <br/>
      Go to <a href='https://www.allwaves.app/dashboard'>Allwaves</a> to check them out !
      <br/>
      <br/>
      <img  width='30' height='30' src='https://www.allwaves.app/assets/allWaves_logo_bright-2b67b30f1f62c4e76a20643216f784cb1eca3880b20208e63ab4ba11a93ad73e.png' alt='Allwaves-logo'>     
      Allwaves Team
    ")
    mail = SendGrid::Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end

end
