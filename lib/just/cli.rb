require "rainbow"

require "just/cli/add"
require "just/cli/list_files"
require "just/cli/list_repos"
require "just/cli/use"
require "just/cli/reset"

module Just
  module CLI
    def self.success(text)
      puts Rainbow(text).green
    end

    def self.error(text)
      puts Rainbow(text).red
    end
  end
end
