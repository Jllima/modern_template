# test/test_helper.rb
require "simplecov"
SimpleCov.coverage_dir "docs/coverage"

SimpleCov.start "rails" do
  add_filter "/bin/"
  add_filter "/db/"
  add_filter "/test/"
  
  # A MÁGICA AQUI: Força o rastreio de tudo na pasta app e lib
  track_files "{app,lib}/**/*.rb" 
end

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"


module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
