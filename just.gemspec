
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "just/version"

Gem::Specification.new do |spec|
  spec.name          = "just"
  spec.version       = Just::VERSION
  spec.authors       = ["Ryan Bigg"]
  spec.email         = ["git@ryanbigg.com"]

  spec.summary       = %q{I'm just visiting thanks}
  spec.description   = %q{I'm just visiting thanks}
  spec.homepage      = "https://github.com/radar/just"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "main", "~> 6.2.2"
  spec.add_dependency "rugged", "~> 0.26.0"
  spec.add_dependency "ruby-progressbar", "~> 1.9.0"
  spec.add_dependency "dry-transaction", "~> 0.10.2"
  spec.add_dependency "dry-monads", "~> 0.4.0"
  spec.add_dependency "rainbow", "~> 3.0.0"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "climate_control", "~> 0.2.0"
end
