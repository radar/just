require 'spec_helper'

RSpec.describe Just::CLI::Add do
  context "run" do
    let(:run_command) { Just::CLI::Add.new("radar/dot-files").run }
    around { |example| ClimateControl.modify(HOME: Just.test_directory) { example.run } }

    it "creates the ~/.just directory" do
      run_command
      expect(File).to exist(Just.test_directory)
    end

    it "clones the repository" do
      run_command
      expect(File).to exist(Just.path("radar/dot-files"))
    end
  end
end
