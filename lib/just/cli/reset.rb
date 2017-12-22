require 'dry/transaction'

module Just
  module CLI
    class Reset
      include Dry::Transaction

      step :run

      def run(_)
        File.open(Just.aliases, "w+") do |f|
          f.truncate(0)
        end

        Success("Cleared all aliases")
      end
    end
  end
end
