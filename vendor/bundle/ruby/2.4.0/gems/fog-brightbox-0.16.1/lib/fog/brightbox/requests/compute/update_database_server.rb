module Fog
  module Compute
    class Brightbox
      class Real
        # @param [String] identifier Unique reference to identify the resource
        # @param [Hash] options
        # @option options [String] :name
        # @option options [String] :description
        # @option options [Array] :allow_access ...
        # @option options [String] :maintenance_weekday Numerical index of weekday (0 is Sunday, 1 is Monday...) to set when automatic updates may be performed
        # @option options [String] :maintenance_hour Number representing 24hr time start of maintenance window hour for x:00-x:59 (0-23)
        # @option options [String] :snapshots_schedule Crontab pattern for scheduled snapshots. Must be at least hourly
        # @option options [Boolean] :nested passed through with the API request. When true nested resources are expanded.
        #
        # @return [Hash] if successful Hash version of JSON object
        # @return [NilClass] if no options were passed
        #
        # @see https://api.gb1.brightbox.com/1.0/#database_server_update_database_server
        #
        def update_database_server(identifier, options)
          return nil if identifier.nil? || identifier == ""
          return nil if options.empty? || options.nil?
          wrapped_request("put", "/1.0/database_servers/#{identifier}", [200], options)
        end
      end
    end
  end
end
