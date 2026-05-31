require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ModernTemplate
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # # Configuração dos Geradores
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: false,
        view_specs: false,      # Não testamos views isoladas (usamos System Specs)
        helper_specs: false,    # Helpers raramente precisam de testes isolados
        routing_specs: false,   # Rotas são testadas nos Request Specs
        controller_specs: false,# Controller specs são obsoletos (usamos Request Specs)
        request_specs: true
      g.fixture_replacement :factory_bot, dir: "spec/factories"


      g.assets false          # Não gera arquivos de CSS/JS inúteis por model
      g.helper false          # Não gera arquivos Helper vazios
      g.jbuilder false        # Não gera views JSON (a menos que seja uma API explícita)
      g.system_tests false    # Desliga testes de sistema do Minitest (vamos focar no RSpec)
    end
  end
end
