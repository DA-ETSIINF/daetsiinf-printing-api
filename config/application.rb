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
    config.filter_parameters += [:file]
    # Cors middleware for angular
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
    # minio config
    config.paperclip_defaults = {
      storage: :s3,
      s3_protocol: ':http',
      s3_permissions: 'private',
      s3_region: 'us-east-1',
      s3_credentials: {
        bucket: 'bucket',
        access_key_id: 'XZNK59RA5Z0ZQ02B4WKD',
        secret_access_key: 'bPU2wAx8VyH8RznhEw3i2RTyBlDidFBfCk/OFs7U',
      },
      s3_host_name: 'localhost:9000',
      s3_options: {
        endpoint: "http://localhost:9000", # for aws-sdk
        force_path_style: true # for aws-sdk (required for minio)
      },
      url: ':s3_path_url',
      path: "/:class/:id.:extension"
    }
  end
end
