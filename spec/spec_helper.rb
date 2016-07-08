# frozen_string_literal: true
require 'coveralls'
require 'simplecov'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [SimpleCov::Formatter::HTMLFormatter,
   Coveralls::SimpleCov::Formatter]
)
SimpleCov.start do
  add_filter 'spec'
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'jira_dependency_visualizer'
require 'pry'
require 'factory_girl'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    FactoryGirl.find_definitions
    # FactoryGirl.lint
  end
end
