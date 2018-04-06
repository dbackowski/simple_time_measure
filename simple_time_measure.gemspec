
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "simple_time_measure/version"

Gem::Specification.new do |spec|
  spec.name          = "simple_time_measure"
  spec.version       = SimpleTimeMeasure::VERSION
  spec.authors       = ["Damian Baćkowski"]
  spec.email         = ["damianbackowski@gmail.com"]

  spec.summary       = "SimpleTimeMeasure is a ruby gem that allows measuring methods without having to alter code of the methods themselves."
  spec.description   = "SimpleTimeMeasure is a ruby gem that allows measuring methods without having to alter code of the methods themselves."
  spec.homepage      = "https://github.com/dbackowski/simple_time_measure"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.7.0"
end
