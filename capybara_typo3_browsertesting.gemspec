# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capybara_typo3_browsertesting/version'

Gem::Specification.new do |spec|
  spec.name          = "capybara_typo3_browsertesting"
  spec.version       = CapybaraTypo3Browsertesting::VERSION
  spec.authors       = ["Pim Snel"]
  spec.email         = ["pim@lingewoud.nl"]

  spec.summary       = %q{Shared TYPO3 integration tests.}
  spec.description   = %q{Shared TYPO3 integration tests.}
  spec.homepage      = "http://lingewoud.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "minitest", "~> 5.0"
  spec.add_runtime_dependency "minitest-capybara", "~> 0.8"
  spec.add_runtime_dependency 'capybara', '~> 2.15'
  spec.add_runtime_dependency 'capybara-screenshot', '~> 1.0.0'
  spec.add_runtime_dependency 'selenium-webdriver', '~> 3.9'
end
