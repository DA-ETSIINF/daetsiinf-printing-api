require_relative 'boot'

require "rails"
require "action_cable/engine"
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"

Bundler.require(*Rails.groups)

module DaetsiinfPrinting
  class Application < Rails::Application
    config.api_only = true
    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.view_specs = false
      g.helper_specs = false
      g.stylesheets = false
      g.javascript = false
      g.helper = false
    end
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/channels)
    # Cors middleware for angular
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
  end
end
