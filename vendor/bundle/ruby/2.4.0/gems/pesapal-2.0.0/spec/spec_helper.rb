# The Coveralls.wear! must occur before any of your application code is required
# https://coveralls.io/docs/ruby
require 'coveralls'
Coveralls.wear!

require 'faker'
require 'webmock/rspec'
require_relative '../lib/pesapal'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
