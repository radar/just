require "bundler/setup"
require "just"
require "climate_control"
require "ruby-progressbar/outputs/null"

module Just
  def self.test_directory
    File.expand_path(__dir__)
  end

  def self.progress_bar
     ProgressBar::Outputs::Null
  end

  def self.git_url
    File.join(Just.test_directory, "repos")
  end
end

RSpec.configure do |config|
  config.before do
    FileUtils.rm_rf(Just.directory)
  end

  config.around { |example| ClimateControl.modify(HOME: Just.test_directory) { example.run } }

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
