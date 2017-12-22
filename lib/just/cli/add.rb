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
        return Success(username_and_repo) unless Dir.exist?(destination)
        return Success(username_and_repo) if Dir.empty?(destination)

        destination_already_exists(username_and_repo, destination)
      end

      def clone_repository(username_and_repo)
        destination = Just.path(username_and_repo)
        Git.clone(Just.git(username_and_repo), destination)


        Success(username_and_repo)
      end

      def destination_already_exists(username_and_repo, destination)
        Failure(<<~DOC
          Destination already exists and is not an empty directory:
            * (#{destination})

          It's likely that you've already added #{username_and_repo} using `just add`.
          Maybe you didn't remember doing this?
        DOC
        )
      end
    end
  end
end
