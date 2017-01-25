ActiveSupport.to_time_preserves_timezone = true
Rails.application.config.active_record.belongs_to_required_by_default = true
ActiveSupport.halt_callback_chains_on_return_false = false
Rails.application.config.ssl_options = { hsts: { subdomains: true } }
