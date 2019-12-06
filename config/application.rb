require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MongoBase
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    #  config.active_job.queue_adapter = :sucker_punch
    #  config.active_job.queue_adapter = :sidekiq
    #  config.active_job.queue_adapter = :resque

    config.time_zone = 'Eastern Time (US & Canada)'

    config.action_mailer.default_url_options = {host: ENV.fetch('APP_HOST')}
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_deliveries = true
    config.action_mailer.default :charset => 'utf-8'

    config.action_mailer.smtp_settings = {
      :address => ENV.fetch('SMTP_ADDRESS'),
      :port => ENV.fetch('MAILER_PORT'),
      :domain => ENV.fetch('MAILER_DOMAIN'),
      :authentication => 'plain',
      :user_name => ENV.fetch('MAILER_EMAIL'),
      :password => ENV['MAILER_PASSWORD'],

      :enable_starttls_auto => true
      # :openssl_verify_mode => 'none'
    }
  end
end

ENV['DATETIME_DISPLAY_FORMATTER'] = "%B %e, %Y %l:%M%P"
ENV['DATE_DISPLAY_FORMATTER'] = "%B %e, %Y"
