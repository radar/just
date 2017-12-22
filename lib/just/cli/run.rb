require "main"

Main {
  mode 'setup' do
    def run()
      doc = <<-DOC
To setup Just, you just need to add this line to your ~/.bash_profile or ~/.zshrc:

. ~/.just/aliases

It's just that simple. Just will do the rest!
      DOC

      Just::CLI.success doc.strip
    end
  end

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
        Just::CLI.success "Added #{repo} successfully."
      else
        Just::CLI.error result.value
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
      repo = params['repo'].value
      aliases = params['aliases'].values
      Just::CLI::Use.new.call(
        username_and_repo: repo,
        aliases: aliases
      )

      Just::CLI.success "Now using the following aliases from #{repo}:"
      aliases.each do |file|
        Just::CLI.success "  * #{file}"
      end
    end
  end

  mode 'me' do
    def run()
      Just::CLI::Reset.new.call(nil)
      Just::CLI.success "Just you!"
      Just::CLI.success "Reloading your shell to reset aliases"

      exec ENV['SHELL']
    end
  end
}
