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
    config.filter_parameters += [:file, :password, :password_confirmation]
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
        bucket: 'documents',
        access_key_id: ENV['ACCESS_KEY'],
        secret_access_key: ENV['SECRET_KEY'],
      },
      s3_host_name: 'da.etsiinf.upm.es:9000',
      s3_options: {
        endpoint: "http://da.etsiinf.upm.es:9000", # for aws-sdk
        force_path_style: true # for aws-sdk (required for minio)
      },
      url: ':s3_path_url',
      path: "/:id.:extension"
    }
  end
end
