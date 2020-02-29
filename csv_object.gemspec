lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "csv_object/version"

Gem::Specification.new do |spec|
  spec.name          = "csv_object"
  spec.version       = CsvObject::VERSION
  spec.authors       = ["Ivan Nemytchenko"]
  spec.email         = ["nemytchenko@gmail.com"]

  spec.summary       = %q{Wrapper around Ruby's CSV for more convenience}
  spec.description   = %q{Ever found yourself trying to find the right way to use Ruby's CSV library? Confused about all those CSV.parse and CSV.open, and when to use each of them? The purpose of CsvObject gem is to create convenient interface to work with CSV files and data in Ruby. Whatever you have: string with filename, CSV data itself, Pathname, CSV::Table, array of hashes, or even Paperclip::Attachment, just throw it into CsvObject.new(your_stuff)}
  spec.homepage      = "https://github.com/inem/csv_object"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/inem/csv_object"
  spec.metadata["changelog_uri"] = "https://github.com/inem/csv_object/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-power_assert", "~> 0.3"
  spec.add_development_dependency "pry", "~> 0.12"
end
