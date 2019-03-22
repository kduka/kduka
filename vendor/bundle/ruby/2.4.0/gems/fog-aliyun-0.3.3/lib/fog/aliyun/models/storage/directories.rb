# frozen_string_literal: true

require 'fog/core/collection'
require 'fog/aliyun/models/storage/directory'

module Fog
  module Storage
    class Aliyun
      class Directories < Fog::Collection
        model Fog::Storage::Aliyun::Directory

        def all
          containers = service.get_containers
          return nil if containers.nil?
          data = []
          i = 0
          containers.each do |entry|
            key = entry['Prefix'][0]
            key[-1] = ''
            data[i] = { key: key }
            i += 1
          end

          load(data)
        end

        def get(key, options = {})
          if !key.nil? && key != '' && key != '.'
            dir = key + '/'
            ret = service.head_object(dir, options)
            new(key: key) if ret.data[:status] == 200
          else
            new(key: '')
          end
        rescue Fog::Storage::Aliyun::NotFound
          nil
        end
      end
    end
  end
end
