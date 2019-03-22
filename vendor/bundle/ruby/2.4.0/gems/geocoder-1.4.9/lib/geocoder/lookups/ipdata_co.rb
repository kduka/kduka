require 'geocoder/lookups/base'
require 'geocoder/results/ipdata_co'

module Geocoder::Lookup
  class IpdataCo < Base

    def name
      "ipdata.co"
    end

    def supported_protocols
      [:https]
    end

    def query_url(query)
      "#{protocol}://#{host}/#{query.sanitized_text}"
    end

    private # ---------------------------------------------------------------

    def results(query)
      Geocoder.configure(:ipdata_co => {:http_headers => { "api-key" => configuration.api_key }}) if configuration.api_key
      # don't look up a loopback address, just return the stored result
      return [reserved_result(query.text)] if query.loopback_ip_address?
      # note: Ipdata.co returns plain text on bad request
      (doc = fetch_data(query)) ? [doc] : []
    end

    def reserved_result(ip)
      {
        "ip"           => ip,
        "city"         => "",
        "region_code"  => "",
        "region_name"  => "",
        "metrocode"    => "",
        "zipcode"      => "",
        "latitude"     => "0",
        "longitude"    => "0",
        "country_name" => "Reserved",
        "country_code" => "RD"
      }
    end

    def host
      "api.ipdata.co"
    end

    def check_response_for_errors!(response)
      if response.code.to_i == 403
        raise_error(Geocoder::RequestDenied) ||
          Geocoder.log(:warn, "Geocoding API error: 403 API key does not exist")
      else
        super(response)
      end
    end
  end
end
