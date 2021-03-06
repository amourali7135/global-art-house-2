require_relative 'boot'

require 'rails/all'

# require 'carrierwave'

# config.assets.compile = false


# def markdown_to_html(text)
#   Kramdown::Document.new(text, input: "GFM").to_html
# end


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
# ::ActiveRecord = 1
Bundler.require(*Rails.groups)

module GlobalArtHouse2
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework  :test_unit, fixture: false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.assets.initialize_on_precompile = false # WAS SUPPOSED TO BE HERE IN APPLICATION!


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.generators do |g|
      g.test_framework :rspec,
      :fixtures => false,
      :view_specs => false,
      :helper_specs => false,
      :routing_specs => false,
      :controller_specs => true,
      :request_specs => false
    end

  end
end


