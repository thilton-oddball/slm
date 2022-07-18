# frozen_string_literal: true

require_relative "lib/slm/version"

Gem::Specification.new do |spec|
  spec.name = "slm"
  spec.version = Slm::VERSION
  spec.authors = ["Travis Hilton"]
  spec.email = ["travis.hilton@gmail.com"]

  spec.summary = "Spotify list manager"
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 1.2.0"
  spec.add_dependency "json", "~> 2.6.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
