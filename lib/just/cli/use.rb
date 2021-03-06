require 'dry/transaction'

module Just
  module CLI
    class Use
      include Dry::Transaction

      step :expand_file_paths
      step :validate_files_are_present
      step :run

      def run(username_and_repo:, aliases:, files:)
        File.open(Just.aliases, "w+") do |f|
          files.each do |file|
            f.write ". #{file}\n"
          end
        end

        Success(
          username_and_repo: username_and_repo,
          aliases: aliases
        )
      end

      def expand_file_paths(username_and_repo:, aliases:)
        Success(
          username_and_repo: username_and_repo,
          aliases: aliases,
          files: aliases.map do |file|
            Just.path(username_and_repo, file)
          end
        )
      end

      def validate_files_are_present(username_and_repo:, aliases:, files:)
        missing_files = files.map { |f| validate_file_is_present(f) }.select(&:failure?)

        return Failure(missing_files) if missing_files.any?

        Success(
          username_and_repo: username_and_repo,
          aliases: aliases,
          files: files
        )
      end

      private

      def validate_file_is_present(f)
        File.exist?(f) ? Success(f) : Failure("#{f} is missing")
      end
    end
  end
end
