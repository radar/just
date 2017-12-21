require 'spec_helper'

RSpec.describe Just::CLI::Use do
  context "run" do
    before do
      FileUtils.mkdir_p("spec/.just/radar")
      FileUtils.cp_r("spec/repos/radar/dot-files", "spec/.just/radar/dot-files")
    end

    let(:username_and_repo) { "radar/dot-files" }
    let(:aliases) { File.readlines(Just.aliases).map(&:strip) }

    context "with a single file" do
      let(:run_command) do
        subject.call(
          username_and_repo: username_and_repo,
          files: ["ryan-aliases"]
        )
      end

      it "is successful" do
        expect(run_command).to be_success
      end

      it "adds ryan-aliases to .just/aliases" do
        run_command

        ryan_aliases_path = Just.path("#{username_and_repo}/ryan-aliases")
        expect(aliases).to include(". #{ryan_aliases_path}")
      end
    end

    context "with multiple files" do
      let(:run_command) do
        subject.call(
          username_and_repo: username_and_repo,
          files: [
            "ryan-aliases",
            "gitaliases"
          ]
        )
      end

      it "is successful" do
        expect(run_command).to be_success
      end

      it "adds ryan-aliases to .just/aliases" do
        run_command
        ryan_aliases_path = Just.path("#{username_and_repo}/ryan-aliases")
        expect(aliases).to include(". #{ryan_aliases_path}")
      end

      it "adds gitaliases to .just/aliases" do
        run_command
        gitaliases_path = Just.path("#{username_and_repo}/gitaliases")
        expect(aliases).to include(". #{gitaliases_path}")
      end
    end

    context "when a file doesn't exist" do
      let(:run_command) do
        subject.call(
          username_and_repo: username_and_repo,
          files: [
            "ryan-aliases",
            "oogabooga"
          ]
        )
      end

      it "fails" do
        expect(run_command).to be_failure
      end

      it "returns some errors" do
        path = Just.path("radar/dot-files", "oogabooga")
        expect(run_command.value.map(&:value)).to include("#{path} is missing")
      end
    end
  end
end
