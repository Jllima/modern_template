# 1. SIMPLECOV ABSOLUTAMENTE NO TOPO
require "simplecov"
SimpleCov.coverage_dir "docs/coverage"

SimpleCov.start "rails" do
  add_filter "/bin/"
  add_filter "/db/"
  add_filter "/spec/"

  track_files "{app,lib}/**/*.rb"
  # minimum_coverage 80
end

RSpec.configure do |config|
  # 1. PERFIL DE PERFORMANCE
  # Se o RSpec demorar, ele vai imprimir no terminal os 10 testes mais lentos.
  # Isso é excelente para cobrar a fábrica de software se eles criarem testes pesados.
  config.profile_examples = 10

  # 2. PERSISTÊNCIA DE ESTADO (O "Fail Fast")
  # Isso cria um arquivo invisível .rspec_status guardando quais testes falharam.
  config.example_status_persistence_file_path = "spec/examples.txt"
  
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
