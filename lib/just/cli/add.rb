require 'rugged'
require 'ruby-progressbar'
require 'dry/transaction'

module Just
  module CLI
    class Add
      include Dry::Transaction

      step :ensure_just_directory_exists
      step :ensure_destination_empty
      step :clone_repository

      def ensure_just_directory_exists(username_and_repo)
        FileUtils.mkdir_p(Just.directory)
        Success(username_and_repo)
      end

      def ensure_destination_empty(username_and_repo)
        destination = Just.path(username_and_repo)
        if File.exist?(destination) && !Dir.empty?(destination)
          Failure("Destination already exists")
        else
          Success(username_and_repo)
        end
      end


      def clone_repository(username_and_repo)
        progressbar = build_progress_bar(username_and_repo)

        destination = Just.path(username_and_repo)
        Rugged::Repository.clone_at(Just.git(username_and_repo), destination,
          transfer_progress: lambda { |total_objects, _, received_objects, _, _, _, _|
            progress = (received_objects / total_objects.to_f * 100).ceil
            progressbar.progress = progress
        })

        Success(username_and_repo)
      end


      private

      def build_progress_bar(username_and_repo)
        ProgressBar.create(
          output: Just.progress_bar,
          title: "Adding #{username_and_repo}",
          throttle_rate: 0.1,
          length: 80
        )
      end
    end
  end
end
