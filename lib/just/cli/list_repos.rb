require 'dry/transaction'
require 'pathname'

# rubocop:disable Layout/EmptyLinesAroundArguments
module Just
  module CLI
    class ListRepos
      include Dry::Transaction
      ERRORS = {
        no_repos: <<~DOC
          You haven't added any repositories to Just yet.

          You can add one by doing `just add <username>/<repo>`.
        DOC
      }.freeze

      step :ensure_at_least_one_repo
      step :list

      def ensure_at_least_one_repo(_)
        return Failure(ERRORS[:no_repos]) if repos.count.zero?
        Success(repos)
      end

      def list(repos)
        Success(repos)
      end

      private

      def repos
        (Dir[Just.path("*/*")] - [".", ".."]).select { |f| File.directory?(f) }.map do |dir|
          Pathname.new(dir).relative_path_from(Just.directory)
        end.map(&:to_s)
      end
    end
  end
end
# rubocop:enable Layout/EmptyLinesAroundArguments
