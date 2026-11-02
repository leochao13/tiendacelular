require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tiendacelular
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1
 # available languages
 config.i18n.available_locales = [:en, :es]

    # lenguage by default
    config.i18n.default_locale = :es

    # Allow multiquery
    config.active_record.async_query_executor = :global_thread_pool

     # Background job
     config.active_job.queue_adapter = :sidekiq
  end
end
