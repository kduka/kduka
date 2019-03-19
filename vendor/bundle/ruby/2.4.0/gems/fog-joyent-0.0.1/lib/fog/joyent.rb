require 'pathname'
require 'fog/core'

module Fog
  module Joyent
    mod_path = Pathname.new(File.expand_path("../joyent", __FILE__))

    autoload :Analytics, mod_path.join("analytics.rb")
    autoload :Compute, mod_path.join("compute.rb")

    extend Fog::Provider

    service(:analytics, 'Analytics')
    service(:compute, 'Compute')
  end
end
