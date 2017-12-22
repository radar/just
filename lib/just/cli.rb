require 'main'

Main {
  mode 'add' do
    argument('repo') {
      required
      synopsis 'repo'
      description 'Path to dot files repository'
    }

    def run()
      repo = params['repo'].value
      result = Just::CLI::Add.new.call(repo)
      if result.success?
        puts "Added #{repo} successfully."
      else
        puts result.value
      end
    end
  end

  mode 'use' do
    argument('repo') {
      synopsis 'repo'
      required
      description 'Repo to use'
    }

    argument('aliases') {
      synopsis 'aliases'
      arity -1
      description 'Dot files to use'
    }

    def run()
      Just::CLI::Use.new.call(
        username_and_repo: params['repo'].value,
        aliases: params['aliases'].values
      )
    end
  end

  mode 'uninstall' do
    def run() puts 'uninstalling...' end
  end
}
