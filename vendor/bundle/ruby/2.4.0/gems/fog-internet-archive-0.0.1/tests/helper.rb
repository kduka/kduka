ENV["FOG_RC"]         = ENV["FOG_RC"] || File.expand_path("../.fog", __FILE__)
ENV["FOG_CREDENTIAL"] = ENV["FOG_CREDENTIAL"] || "default"

require "fog/internet_archive"
require "securerandom"

Excon.defaults.merge!(:debug_request => true, :debug_response => true)

require File.expand_path(File.join(File.dirname(__FILE__), "helpers", "mock_helper"))

# This overrides the default 600 seconds timeout during live test runs
if Fog.mocking?
  FOG_TESTING_TIMEOUT = ENV["FOG_TEST_TIMEOUT"] || 2000
  Fog.timeout = 2000
  Fog::Logger.warning "Setting default fog timeout to #{Fog.timeout} seconds"
else
  FOG_TESTING_TIMEOUT = Fog.timeout
end

def lorem_file
  File.open(File.dirname(__FILE__) + "/lorem.txt", "r")
end

def array_differences(array_a, array_b)
  (array_a - array_b) | (array_b - array_a)
end

def generate_unique_domain(with_trailing_dot = false)
  # get time (with 1/100th of sec accuracy)
  # want unique domain name and if provider is fast, this can be called more than once per second
  time = (Time.now.to_f * 100).to_i
  domain = "test-" + time.to_s + ".com"
  domain += "." if with_trailing_dot

  domain
end
