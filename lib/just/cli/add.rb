require 'rugged'
require 'ruby-progressbar'

module Just
  class CLI
    class Add
      attr_reader :username_and_repo

      def initialize(username_and_repo)
        @username_and_repo = username_and_repo
      end

      def run
        create_just_directory

        progressbar = build_progress_bar

        destination = Just.path(username_and_repo)
        Rugged::Repository.clone_at(url, destination,
          transfer_progress: lambda { |total_objects, _, received_objects, _, _, _, _|
            progress = (received_objects / total_objects.to_f * 100).ceil
            progressbar.progress = progress
        })

        File.open(Just.path("aliases"), "w+") do |f|
          f.write(". ~/.just/#{username_and_repo}")
        end
      end

      private

      def build_progress_bar
        ProgressBar.create(
          output: Just.progress_bar,
          title: "Adding #{username_and_repo}",
          throttle_rate: 0.1,
          length: 80
        )
      end

      def create_just_directory
        FileUtils.mkdir_p("~/.just")
      end

      def url
        "#{Just.git_url}/#{username_and_repo}"
      end
    end
  end
end
