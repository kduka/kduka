module Fog
  module Compute
    class Brightbox
      class Real
        # @param [Hash] options
        # @option options [String] :name
        # @option options [String] :description
        # @option options [String] :engine Database engine to request
        # @option options [String] :version Database version to request
        # @option options [Array] :allow_access ...
        # @option options [String] :maintenance_weekday Numerical index of weekday (0 is Sunday, 1 is Monday...) to set when automatic updates may be performed
        # @option options [String] :maintenance_hour Number representing 24hr time start of maintenance window hour for x:00-x:59 (0-23)
        # @option options [String] :snapshots_schedule Crontab pattern for scheduled snapshots. Must be at least hourly
        # @option options [String] :snapshot
        # @option options [String] :zone
        # @option options [Boolean] :nested passed through with the API request. When true nested resources are expanded.
        #
        # @return [Hash] if successful Hash version of JSON object
        # @return [NilClass] if no options were passed
        #
        # @see https://api.gb1.brightbox.com/1.0/#database_server_create_database_server
        #
        def create_database_server(options)
          wrapped_request("post", "/1.0/database_servers", [202], options)
        end
      end
    end
  end
end
