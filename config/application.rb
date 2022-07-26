require_relative "boot"

require "rails/all"

require "roo"
require "rails/all"
require "activerecord-import/base"
ActiveRecord::Import.require_adapter("mysql2")

Bundler.require(*Rails.groups)
module RubyOe42ExamSystem
  class Application < Rails::Application
    config.load_defaults 6.0
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :vi
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
