Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true


  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Use default logging formatter so that PID and timestamp are not suppressed.
  # config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')
  
  config.log_level = :info

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Lograge config
  formatter = ::Logger::Formatter.new
  formatter = proc { |severity, datetime, progname, msg|
    if severity == "FATAL"
      # suppress fatal logs since they mess up the
      # lograge format, and the information is already in
      # the preceeding INFO message anyway
      ""
    else
      "#{msg}\n"
    end
  }
  config.log_formatter = formatter

  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new


  config.lograge.custom_options = lambda do |event|
    # puts "event: #{event.payload[:uid]}"
    unwanted_keys = %w(format action controller)

    params = event.payload[:params].reject { |k,_| unwanted_keys.include? k }

    ret = {
      app: Rails.application.class.parent_name.underscore,
      environment: Rails.env,
      params: params
    }

    # add exception message
    if (eo = event.payload[:exception_object]) 
      ret.merge!({
        exception: event.payload[:exception]
      })
    end

    # add user id
    if (user_id = event.payload[:uid]) 
      ret.merge!({
        user_id: user_id
      })
    end

    ret
  end
end
