require File.expand_path('../boot', __FILE__)


require 'rails/all'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kduka
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.assets.initialize_on_precompile = false
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    # Rails 5

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end

    config.to_prepare do
      Devise::ConfirmationsController.layout "login/user_login"
      StorePasswordsController.layout "login/store_login"
      UserPasswordsController.layout "login/user_login"
    end

    api_key = Rails.env.production? ? ENV.fetch('POSTMARK_PROD_API_KEY') : ENV.fetch('POSTMARK_DEV_API_KEY')

    config.action_mailer.delivery_method = :postmark
    config.action_mailer.postmark_settings = { api_token: api_key }

  end
end
