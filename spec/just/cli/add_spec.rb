require 'spec_helper'

RSpec.describe Just::CLI::Add do
  context "run" do
    let(:repo) { "radar/dot-files" }
    let(:run_command) { subject.call(repo) }
    context "when the directory does not already exist" do
      it "creates the ~/.just directory" do
        run_command
        expect(File).to exist(Just.test_directory)
      end

      it "clones the repository" do
        run_command
        expect(File).to exist(Just.path("radar/dot-files"))
      end
    end

    context "when the directory already exists" do
      before do
        path = Just.path("radar/dot-files")
        FileUtils.mkdir_p(path)
        FileUtils.touch(File.join(path, "aliases"))
      end

      it "fails + returns an error" do
        error = described_class::ERRORS[:destination_already_exists]
        result = run_command
        expect(result).to be_failure
        expect(result.value).to eq(error.(repo, Just.path(repo)))
      end
    end
  end
end
