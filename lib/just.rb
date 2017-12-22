require "just/version"
require "just/cli"

module Just
  def self.progress_bar
     ProgressBar::Outputs::Tty
  end

  def self.directory
    File.expand_path(File.join(ENV['HOME'], ".just"))
  end

  def self.path(*paths)
    File.expand_path(File.join(directory, *paths))
  end

  def self.aliases
    path("aliases")
  end

  def self.git_url
    "https://github.com"
  end

  def self.git(*paths)
    File.join(git_url, *paths)
  end
end
