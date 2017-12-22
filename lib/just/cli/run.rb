require "main"

# rubocop:disable Metrics/BlockLength
Main do
  mode 'setup' do
    def run
      doc = <<~DOC
        To setup Just, you just need to add this line to your ~/.bash_profile or ~/.zshrc:

        . ~/.just/aliases

        You should add this _before_ any of the host computer's aliases.
        Just so that that computer's aliases take precedence!

        It's just that simple. Just will do the rest!
      DOC

      Just::CLI.success doc.strip
    end
  end

  mode 'add' do
    argument('repo') do
      required
      synopsis 'repo'
      description 'Path to dot files repository'
    end

    def run
      repo = params['repo'].value
      puts "Cloning #{repo}..."

      result = Just::CLI::Add.new.call(repo)
      if result.success?
        Just::CLI.success "Added #{repo} successfully."
      else
        Just::CLI.error result.value
      end
    end
  end

  mode 'use' do
    argument('repo') do
      synopsis 'repo'
      required
      description 'Repo to use'
    end

    argument('aliases') do
      synopsis 'aliases'
      arity(-1)
      description 'Dot files to use'
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def run
      repo = params['repo'].value
      aliases = params['aliases'].values
      result = Just::CLI::Use.new.call(
        username_and_repo: repo,
        aliases: aliases
      )

      if result.failure?
        errors = result.value.map(&:value)
        Just::CLI.error "The following files were not found:"
        errors.each do |file|
          Just::CLI.error "  * #{file}"
        end
        return
      end

      Just::CLI.success "Now using the following aliases from #{repo}:"
      aliases.each do |file|
        Just::CLI.success "  * #{file}"
      end

      reload_shell!
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength
  end

  mode 'list' do
    argument('repo') do
      optional
    end

    def run
      if params['repo'].given?
        repo = params['repo'].value
        list_files(Just::CLI::ListFiles.new.call(repo))
      else
        list_repositories(Just::CLI::ListRepos.new.call(nil))
      end
    end

    private

    def list_files(result)
      if result.success?
        repo = result.value[:repo]
        files = result.value[:files]

        Just::CLI.success "#{repo} has the following files to pick from:"
        files.each do |file|
          puts "* #{file}"
        end

        Just::CLI.success "You can choose to use one of these files by running this command:"
        puts ""
        Just::CLI.success "just use #{repo} #{files.sample}"
      end
    end
  end

  mode 'reset' do
    def run
      reset
    end
  end

  mode 'me' do
    def run
      reset
    end
  end

  def reset
    Just::CLI::Reset.new.call(nil)
    Just::CLI.success "Just you!"

    reload_shell!
  end

  def reload_shell!
    puts ""
    Just::CLI.success "Reloading your shell to reset aliases..."
    exec ENV['SHELL']
  end

  def run
    help!
  end
end
# rubocop:enable Metrics/BlockLength
