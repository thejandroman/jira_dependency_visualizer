# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jira_dependency_visualizer/version'

Gem::Specification.new do |s|
  s.authors               = ['Alejandro Figueroa']
  s.bindir                = 'bin'
  s.description           = 'Creates a graphviz file from a JIRA ticket\'s dependencies'
  s.email                 = ['alejandro@ideasftw.com']
  s.executables << 'jira_dependency_visualizer'
  s.files                 = Dir['lib/**/*.rb'] + Dir['bin/*'] + Dir['[A-Z]*'] + Dir['spec/**/*']
  s.homepage              = 'https://github.com/thejandroman/jira_dependency_visualizer'
  s.license               = 'MIT'
  s.name                  = 'jira_dependency_visualizer'
  s.required_ruby_version = ['>= 2.1.0', '<= 2.3.0']
  s.summary               = 'Creates a graphviz file from a JIRA ticket\'s dependencies'
  s.version               = JiraDependencyVisualizer::VERSION

  s.add_dependency 'jira-ruby', '~> 1.0'
  s.add_dependency 'ruby-graphviz', '~> 1.2'

  s.add_development_dependency 'bundler', '~> 1.11'
  s.add_development_dependency 'coveralls', '~> 0.8'
  s.add_development_dependency 'factory_girl', '~> 4.5'
  s.add_development_dependency 'pry', '~> 0.10'
  s.add_development_dependency 'rake', '~> 10.5'
  s.add_development_dependency 'rspec', '~> 3.4'
  s.add_development_dependency 'rubocop', '~> 0.52'
  s.add_development_dependency 'yard', '~> 0.8'
end
