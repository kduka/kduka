require "dry/inflector"

module Fog
  module Brightbox
    module ModelHelper
      def resource_name
        inflector.underscore(inflector.demodulize(self.class))
      end

      def collection_name
        inflector.pluralize(resource_name)
      end

      private

      def inflector
        @inflector ||= Dry::Inflector.new
      end
    end
  end
end
