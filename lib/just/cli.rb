require 'main'

Main {
  mode 'add' do
    name 'just add'
    argument('repo') {
      required
      synopsis 'repo'
      description 'Path to dot files repository'
    }

    def run()
      Just::CLI::Add.new(params['username'].value).run
      puts "Added #{username_and_repo} successfully."
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
      Just::CLI::Use.new.run(
        params['repo'].value,
        params['aliases'].values
      )
    end
  end

  mode 'uninstall' do
    def run() puts 'uninstalling...' end
  end
}
