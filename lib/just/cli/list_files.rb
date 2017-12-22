require 'forwardable'

module Just
  module CLI
    class ListFiles
      include Dry::Transaction
      extend Forwardable

      delegate [:path] => Just

      ERRORS = {
        no_such_directory: <<~DOC
          That directory you specified does not exist.
        DOC
      }

      step :check_if_path_exists
      step :list

      def check_if_path_exists(repo)
        return Failure(ERRORS[:no_such_directory]) unless Dir.exist?(path(repo))
        Success(repo)
      end

      def list(repo)
        files = (Dir.entries(path(repo))).reject { |f| /\A\./.match(f) }
        Success(files)
      end
    end
  end
end
