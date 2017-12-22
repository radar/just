require 'spec_helper'
RSpec.describe Just::CLI::ListRepos do
  let(:repo) { "radar/dot-files" }

  let(:run_command) { Just::CLI::ListRepos.new.call(nil) }

  context "when at least one repo exists" do
    before do
      FileUtils.mkdir_p(Just.path(repo))
      FileUtils.touch(Just.path(repo, "gitaliases"))
      FileUtils.touch(Just.path(repo, "ryanaliases"))
    end

    it "succeeds" do
      result = run_command
      expect(result).to be_success
    end

    it "lists repos" do
      result = run_command
      expect(result.value).to eq([repo])
    end
  end

  context "when no repos exist" do
    it "fails" do
      result = run_command
      expect(result).to be_failure
    end

    it "returns an error message" do
      result = run_command
      expect(result.value).to eq(described_class::ERRORS[:no_repos])
    end
  end
end
