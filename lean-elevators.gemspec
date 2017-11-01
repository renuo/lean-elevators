# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'lean-elevators'
  spec.version       = '0.1.0'.freeze
  spec.authors       = ['Josua Schmid', 'Simon Huber']
  spec.email         = %w[josua.schmid@renuo.ch simon.huber@renuo.ch]

  spec.summary       = 'This library contains the business logic to the lean elevators challenge of Renuo'
  spec.homepage      = 'https://github.com/renuo/lean-elevators'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'rubocop', '~> 0.49'
  spec.add_development_dependency 'simplecov', '~> 0.14'
end
