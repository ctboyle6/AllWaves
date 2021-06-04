require 'sendgrid-ruby'
include SendGrid

class UserNotifierMailer < ApplicationMailer
  # default :from => 'allwavesproject@gmail.com'
  
  def update_conditions(user,user_spot)
    from = Email.new(email: 'allwavesproject@gmail.com')
    to = Email.new(email: user.email)
    subject = "#{user_spot.name.capitalize} conditions have been updated !"
    content = Content.new(type: 'text/html', value: "
     <!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Strict//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'><html data-editor-version='2' class='sg-campaigns' xmlns='http://www.w3.org/1999/xhtml'><head>
      <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
      <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
      <!--[if !mso]><!-->
      <meta http-equiv='X-UA-Compatible' content='IE=Edge'>
      <!--<![endif]-->
      <!--[if (gte mso 9)|(IE)]>
      <xml>
        <o:OfficeDocumentSettings>
          <o:AllowPNG/>
          <o:PixelsPerInch>96</o:PixelsPerInch>
        </o:OfficeDocumentSettings>
      </xml>
      <![endif]-->
      <!--[if (gte mso 9)|(IE)]>
  <style type='text/css'>
    body {width: 600px;margin: 0 auto;}
    table {border-collapse: collapse;}
    table, td {mso-table-lspace: 0pt;mso-table-rspace: 0pt;}
    img {-ms-interpolation-mode: bicubic;}
  </style>
<![endif]-->
      <style type='text/css'>
    body, p, div {
      font-family: inherit;
      font-size: 14px;
    }
    body {
      color: #000000;
    }
    body a {
      color: #1188E6;
      text-decoration: none;
    }
    p { margin: 0; padding: 0; }
    table.wrapper {
      width:100% !important;
      table-layout: fixed;
      -webkit-font-smoothing: antialiased;
      -webkit-text-size-adjust: 100%;
      -moz-text-size-adjust: 100%;
      -ms-text-size-adjust: 100%;
    }
    img.max-width {
      max-width: 100% !important;
    }
    .column.of-2 {
      width: 50%;
    }
    .column.of-3 {
      width: 33.333%;
    }
    .column.of-4 {
      width: 25%;
    }
    @media screen and (max-width:480px) {
      .preheader .rightColumnContent,
      .footer .rightColumnContent {
        text-align: left !important;
      }
      .preheader .rightColumnContent div,
      .preheader .rightColumnContent span,
      .footer .rightColumnContent div,
      .footer .rightColumnContent span {
        text-align: left !important;
      }
      .preheader .rightColumnContent,
      .preheader .leftColumnContent {
        font-size: 80% !important;
        padding: 5px 0;
      }
      table.wrapper-mobile {
        width: 100% !important;
        table-layout: fixed;
      }
      img.max-width {
        height: auto !important;
        max-width: 100% !important;
      }
      a.bulletproof-button {
        display: block !important;
        width: auto !important;
        font-size: 80%;
        padding-left: 0 !important;
        padding-right: 0 !important;
      }
      .columns {
        width: 100% !important;
      }
      .column {
        display: block !important;
        width: 100% !important;
        padding-left: 0 !important;
        padding-right: 0 !important;
        margin-left: 0 !important;
        margin-right: 0 !important;
      }
    }
  </style>
      <!--user entered Head Start--><link href='https://fonts.googleapis.com/css?family=Francois+One&display=swap' rel='stylesheet'><style>
    body {font-family: 'Francois One', sans-serif;}
</style><!--End Head user entered-->
    </head>
    <body>
      <center class='wrapper' data-link-color='#1188E6' data-body-style='font-size:14px; font-family:inherit; color:#000000; background-color:#FFFFFF;'>
        <div class='webkit'>
          <table cellpadding='0' cellspacing='0' border='0' width='100%' class='wrapper' bgcolor='#FFFFFF'>
            <tbody><tr>
              <td valign='top' bgcolor='#FFFFFF' width='100%'>
                <table width='100%' role='content-container' class='outer' align='center' cellpadding='0' cellspacing='0' border='0'>
                  <tbody><tr>
                    <td width='100%'>
                      <table width='100%' cellpadding='0' cellspacing='0' border='0'>
                        <tbody><tr>
                          <td>
                            <!--[if mso]>
    <center>
    <table><tr><td width='600'>
  <![endif]-->
                                    <table width='100%' cellpadding='0' cellspacing='0' border='0' style='width:100%; max-width:600px;' align='center'>
                                      <tbody><tr>
                                        <td role='modules-container' style='padding:0px 0px 0px 0px; color:#000000; text-align:left;' bgcolor='#FFFFFF' width='100%' align='left'><table class='module preheader preheader-hide' role='module' data-type='preheader' border='0' cellpadding='0' cellspacing='0' width='100%' style='display: none !important; mso-hide: all; visibility: hidden; opacity: 0; color: transparent; height: 0; width: 0;'>
    <tbody><tr>
      <td role='module-content'>
        <p></p>
      </td>
    </tr>
  </tbody></table><table border='0' cellpadding='0' cellspacing='0' align='center' width='100%' role='module' data-type='columns' style='padding:0px 5px 0px 5px; background-color: rgba(5,40,80, 0.9);' bgcolor='#167FFB'>
    <tbody>
      <tr role='module-content'>
        <td height='100%' valign='top'>
          <table class='column' width='590' style='width:590px; border-spacing:0; border-collapse:collapse; margin:0px 0px 0px 0px;' cellpadding='0' cellspacing='0' align='left' border='0' bgcolor=''>
            <tbody>
              <tr>
                <td style='padding:0px;margin:0px;border-spacing:0;'><table class='module' role='module' data-type='spacer' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-muid='f1b09aa4-74fe-4a39-b804-6a6415600885'>
    <tbody>
      <tr>
        <td style='padding:0px 0px 30px 0px;' role='module-content' bgcolor=''>
        </td>
      </tr>
    </tbody>
  </table><table class='wrapper' role='module' data-type='image' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-muid='365c6f07-e4ac-49da-8420-9192f0588673'>
    <tbody>
      <tr>
        <td style='font-size:6px; line-height:10px; padding:0px 0px 0px 0px;' valign='top' align='center'>
          <a href='http://'><img class='max-width' border='0' style='display:block; color:#000000; text-decoration:none; font-family:Helvetica, arial, sans-serif; font-size:16px;' width='70' alt='' data-proportionally-constrained='true' data-responsive='false' src='https://www.allwaves.app/assets/allWaves_logo_bright-2b67b30f1f62c4e76a20643216f784cb1eca3880b20208e63ab4ba11a93ad73e.png' height='77'></a>
        </td>
      </tr>
    </tbody>
  </table><table class='module' role='module' data-type='spacer' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-muid='63165541-1487-4778-8978-ac1f70f7c3a3'>
    <tbody>
      <tr>
        <td style='padding:0px 0px 30px 0px;' role='module-content' bgcolor=''>
        </td>
      </tr>
    </tbody>
  </table><table class='wrapper' role='module' data-type='image' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-muid='0c3e5127-92d1-4daa-939b-eeb5e8264926'>
    <tbody>
      <tr>
        <td style='font-size:6px; line-height:10px; padding:0px 0px 0px 0px;' valign='top' align='center'>
          <img class='max-width' border='0' style='display:block; color:#000000; text-decoration:none; font-family:Helvetica, arial, sans-serif; font-size:16px; max-width:100% !important; width:100%; height:auto !important;' width='590' alt='' data-proportionally-constrained='true' data-responsive='true' src='https://images.unsplash.com/photo-1459745930869-b3d0d72c3cbb?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=345&ixid=MnwxfDB8MXxyYW5kb218fHx8fHx8fHwxNjIyNzY5MDA3&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=590'>
        </td>
      </tr>
    </tbody>
  </table><table class='module' role='module' data-type='text' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-muid='3da42836-77b6-4afc-b2eb-2d58c47ae549' data-mc-module-version='2019-10-22'>
    <tbody>
      <tr>
        <td style='color: white; padding:30px 0px 20px 0px; line-height:22px; text-align:inherit;' height='100%' valign='top' bgcolor='' role='module-content'><div><div style='font-family: inherit; text-align: center'><span style='font-size: 20px'>#{user_spot.name.capitalize} received new conditions : Check them out!&nbsp;</span></div><div></div></div></td>
      </tr>
    </tbody>
  </table><table border='0' cellpadding='0' cellspacing='0' class='module' data-role='module-button' data-type='button' role='module' style='table-layout:fixed;' width='100%' data-muid='c4eda9b8-984a-4a6d-81e7-98809ab3b930'>
      <tbody>
        <tr>
          <td align='center' bgcolor='' class='outer-td' style='padding:0px 0px 0px 0px;'>
            <table border='0' cellpadding='0' cellspacing='0' class='wrapper-mobile' style='text-align:center;'>
              <tbody>
                <tr>
                <td align='center' bgcolor='#66beff' class='inner-td' style='border-radius:6px; font-size:16px; text-align:center; background-color:inherit;'>
                  <a href='http://www.allwaves.app' style='background-color:#66beff; border:1px solid 66BEFF; border-color:66BEFF; border-radius:0px; border-width:1px; color:#ffffff; display:inline-block; font-size:15px; font-weight:normal; letter-spacing:0px; line-height:normal; padding:12px 50px 12px 50px; text-align:center; text-decoration:none; border-style:solid; font-family:inherit;' target='_blank'>See your Spots</a>
                </td>
                </tr>
              </tbody>
            </table>
          </td>
        </tr>
      </tbody>
    </table><table class='module' role='module' data-type='spacer' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;' data-muid='1affd6a9-cb62-4d92-8832-ec6ee7c68f01'>
    <tbody>
      <tr>
        <td style='padding:0px 0px 50px 0px;' role='module-content' bgcolor=''>
        </td>
      </tr>
    </tbody>
  </table></td>
              </tr>
            </tbody>
          </table>
          
        </td>
      </tr>
    </tbody>
  </table><table border='0' cellpadding='0' cellspacing='0' align='center' width='100%' role='module' data-type='columns' style='padding:0px 5px 0px 5px;' bgcolor='#f5f8fd'>

  
</body></html>
      

    ")
    mail = SendGrid::Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end

end
