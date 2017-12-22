require 'spec_helper'

RSpec.describe Just::CLI::Reset do
  context "run" do
    let(:run_command) { Just::CLI::Reset.new.call(nil) }

    context "when aliases exist" do
      before do
        File.open(Just.aliases, "w+") do |f|
          f.write ". ~/.just/radar/dot-files/gitaliases"
        end
      end

      it "is successful" do
        result = run_command
        expect(result).to be_success
      end

      it "clears the aliases" do
        run_command
        expect(File).to be_empty(Just.aliases)
      end
    end

    context "when aliases file does not exist" do
      it "is successful" do
        result = run_command
        expect(result).to be_success
      end

      it "creates an empty aliases file" do
        run_command
        expect(File).to be_empty(Just.aliases)
      end
    end
  end
end
