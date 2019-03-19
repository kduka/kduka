module Fog
  module Storage
    class Brightbox
      class Real
        # Get an expiring object https url from Cloud Files
        #
        # ==== Parameters
        # * container<~String> - Name of container containing object
        # * object<~String> - Name of object to get expiring url for
        # * expires<~Time> - An expiry time for this url
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~String> - url for object
        def get_object_https_url(container, object, expires, options = {})
          create_temp_url(container, object, expires, "GET", options.merge(:scheme => "https"))
        end
      end
    end
  end
end
