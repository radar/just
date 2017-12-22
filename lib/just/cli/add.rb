require 'git'
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
        destination = Just.path(username_and_repo)
        Git.clone(Just.git(username_and_repo), destination)

        Success(username_and_repo)
      end

    end
  end
end
