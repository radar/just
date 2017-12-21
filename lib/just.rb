require "just/version"
require "just/cli/add"

module Just
  def self.progress_bar
     ProgressBar::Outputs::Tty
  end

  def self.directory
    File.expand_path(File.join(ENV['HOME'], ".just"))
  end

  def self.path(path)
    File.expand_path(File.join(directory, path))
  end

  def self.git_url
    "https://github.com"
  end
end
