class ClientMailer < ApplicationMailer
  default from: "Sage Workspace <#{ENV['MAILER_EMAIL']}>",
          return_path: ENV['MAILER_EMAIL'],
          sender: ENV['MAILER_EMAIL']

  def after_sign_up(client, password)
    delivery_options = {:password => ENV['MAILER_PASSWORD']}
    @client = client
    @password = password

    mail(
      to: @client.emails,
      subject: 'Welcome to SaGE Workspace',
      delivery_method_options: delivery_options
    )
  end
end
