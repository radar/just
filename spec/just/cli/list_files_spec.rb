require 'spec_helper'

RSpec.describe Just::CLI::ListFiles do
  let(:repo) { "radar/dot-files" }
  let(:run_command) { Just::CLI::ListFiles.new.call(repo) }

  context "when the repo exists" do
    before do
      FileUtils.mkdir_p(Just.path(repo))
      FileUtils.touch(Just.path(repo, ".git"))
      FileUtils.touch(Just.path(repo, "ryan-aliases"))
      FileUtils.touch(Just.path(repo, "gitaliases"))
    end

    it "succeeds" do
      result = run_command
      expect(result).to be_success
    end

    it "lists the files" do
      result = run_command
      expect(result.value).to eq(["gitaliases", "ryan-aliases"])
    end
  end

  context "when the repo does not exist" do
    it "fails" do
      result = run_command
      expect(result.value).to eq(described_class::ERRORS[:no_such_directory])
    end
  end
end
