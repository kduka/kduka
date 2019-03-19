module Pesapal
  # Supporting oAuth 1.0 methods. See [oAuth 1.0 spec][1] for details.
  #
  # [1]: http://oauth.net/core/1.0/
  module Oauth
    # Generate query string from a Hash.
    #
    # 1. Percent encode every key and value that will be signed
    # 2. Sort the list of parameters alphabetically by encoded key
    # 3. For each key/value pair
    #      * append the encoded key to the output string
    #      * append the '=' character to the output string
    #      * append the encoded value to the output string
    # 4. If there are more key/value pairs remaining, append a '&' character
    #    to the output string
    #
    # The oauth spec says to sort lexicographically, which is the default
    # alphabetical sort for many libraries. In case of two parameters with the
    # same encoded key, the oauth spec says to continue sorting based on value.
    #
    # @param params [Hash] Hash of parameters.
    #
    # @return [String] valid valid parameter query string.
    def self.generate_encoded_params_query_string(params = {})
      queries = []
      params.each { |k, v| queries.push "#{parameter_encode(k.to_s)}=#{parameter_encode(v.to_s)}" }
      queries.sort!
      queries.join('&')
    end

    # Generate an nonce
    #
    # > _The Consumer SHALL then generate a Nonce value that is unique for all
    # > requests with that timestamp. A nonce is a random string, uniquely
    # > generated for each request. The nonce allows the Service Provider to
    # > verify that a request has never been made before and helps prevent
    # > replay attacks when requests are made over a non-secure channel (such as
    # > HTTP)._
    #
    # See [section 8 of the oAuth 1.0 spec][1]
    #
    # [1]: http://oauth.net/core/1.0/#nonce
    #
    # @param length [Integer] number of characters of the resulting nonce.
    #
    # @return [String] generated random nonce.
    def self.generate_nonce(length)
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
      nonce = ''
      length.times { nonce << chars[rand(chars.size)] }
      nonce
    end

    # Generate the oAuth signature using HMAC-SHA1 algorithm.
    #
    # The signature is calculated by passing the signature base string and
    # signing key to the HMAC-SHA1 hashing algorithm. The output of the HMAC
    # signing function is a binary string. this needs to be Base64 encoded to
    # produce the signature string.
    #
    # For pesapal flow we don't have a token secret to we will set as nil and
    # the appropriate action will be taken as per the oAuth spec. See
    # {generate_signing_key} for details.
    #
    # @param http_method [String] the HTTP method.
    #
    # @param absolute_url [String] the absolute URL.
    #
    # @param params [Hash] URL parameters.
    #
    # @param consumer_secret [String] the consumer secret.
    #
    # @param token_secret [String] the token secret.
    #
    # @return [String] valid oAuth signature.
    def self.generate_oauth_signature(http_method, absolute_url, params, consumer_secret, token_secret = nil)
      digest = OpenSSL::Digest.new('sha1')
      signature_base_string = generate_signature_base_string(http_method, absolute_url, params)
      signing_key = generate_signing_key(consumer_secret, token_secret)
      hmac = OpenSSL::HMAC.digest(digest, signing_key, signature_base_string)
      Base64.encode64(hmac).chomp
    end

    # Generate query string from signable parameters Hash
    #
    # Same as {generate_encoded_params_query_string} but without
    # `:oauth_signature` included in the parameters.
    #
    # @param params [Hash] Hash of parameters.
    #
    # @return [String] valid valid parameter query string.
    def self.generate_signable_encoded_params_query_string(params = {})
      params.delete(:oauth_signature)
      generate_encoded_params_query_string params
    end

    # Generate an oAuth 1.0 signature base string.
    #
    # Three values collected so far must be joined to make a single string, from
    # which the signature will be generated. This is called the signature base
    # string. The signature base string should contain exactly 2 ampersand '&'
    # characters. The percent '%' characters in the parameter string should be
    # encoded as %25 in the signature base string.
    #
    # See [appendix A.5.1 of the oAuth 1.0 spec][1] for an example.
    #
    # [1]: http://oauth.net/core/1.0/#sig_base_example
    #
    # @param http_method [String] the HTTP method.
    #
    # @param absolute_url [String] the absolute URL.
    #
    # @param params [Hash] URL parameters.
    #
    # @return [String] valid signature base string.
    def self.generate_signature_base_string(http_method, absolute_url, params)
      # step 1: convert the http method to uppercase
      http_method = http_method.upcase
      # step 2: percent encode the url
      url_encoded = parameter_encode(normalized_request_uri(absolute_url))
      # step 3: percent encode the parameter string
      parameter_string_encoded = parameter_encode(generate_signable_encoded_params_query_string(params))

      "#{http_method}&#{url_encoded}&#{parameter_string_encoded}"
    end

    # Generate signing key
    #
    # The signing key is simply the percent encoded consumer secret, followed by
    # an ampersand character '&', followed by the percent encoded token secret.
    # Note that there are some flows, such as when obtaining a request token,
    # where the token secret is not yet known. In this case, the signing key
    # should consist of the percent encoded consumer secret followed by an
    # ampersand character '&'.
    #
    # @param consumer_secret [String] the consumer secret.
    #
    # @param token_secret [String] the token secret.
    #
    # @return [String] valid signing key.
    def self.generate_signing_key(consumer_secret, token_secret = nil)
      consumer_secret_encoded = parameter_encode(consumer_secret)
      token_secret_encoded = ''
      token_secret_encoded = parameter_encode(token_secret) unless token_secret.nil?

      "#{consumer_secret_encoded}&#{token_secret_encoded}"
    end

    # Construct normalized request absolute URL.
    #
    # > _The Signature Base String includes the request absolute URL, tying the
    # > signature to a specific endpoint. The URL used in the Signature Base
    # > String MUST include the scheme, authority, and path, and MUST exclude
    # > the query and fragment as defined by [RFC3986] section 3._
    #
    # > _If the absolute request URL is not available to the Service Provider
    # > (it is always available to the Consumer), it can be constructed by
    # > combining the scheme being used, the HTTP Host header, and the relative
    # > HTTP request URL. If the Host header is not available, the Service
    # > Provider SHOULD use the host name communicated to the Consumer in the
    # > documentation or other means._
    #
    # > _The Service Provider SHOULD document the form of URL used in the
    # > Signature Base String to avoid ambiguity due to URL normalization.
    # > Unless specified, URL scheme and authority MUST be lowercase and include
    # > the port number; http default port 80 and https default port 443 MUST be
    # > excluded._
    #
    # See [section 9.1.2 of the oAuth 1.0 spec][1]
    #
    # [1]: http://oauth.net/core/1.0/#anchor14
    #
    # @param absolute_url [String] URL to be normalized.
    #
    # @return [String] valid constructed URL as per the spec.
    def self.normalized_request_uri(absolute_url)
      uri = URI.parse(absolute_url)

      scheme = uri.scheme.downcase
      host = uri.host.downcase
      path = uri.path
      port = uri.port

      non_standard_http = scheme == 'http' && port != 80
      non_standard_https = scheme == 'https' && port != 443
      uri_with_path = path && (path != '')

      port = non_standard_http || non_standard_https ? ":#{port}" : ''
      path = uri_with_path ? path : '/'

      "#{scheme}://#{host}#{port}#{path}"
    end

    # Encodes parameter name or values.
    #
    # > _All parameter names and values are escaped using the [RFC3986] percent-
    # > encoding (%xx) mechanism. Characters not in the unreserved character set
    # > ([RFC3986] section 2.3) MUST be encoded. Characters in the unreserved
    # > character set MUST NOT be encoded. Hexadecimal characters in encodings
    # > MUST be upper case. Text names and values MUST be encoded as UTF-8
    # > octets before percent-encoding them per [RFC3629]._
    #
    # See [section 5.1 of the oAuth 1.0 spec][1]
    #
    # [1]: http://oauth.net/core/1.0/#encoding_parameters
    #
    # @param str [String] parameter name or value.
    #
    # @return [String] valid encoded result as per the spec.
    def self.parameter_encode(str)
      # reserved character regexp, per section 5.1
      reserved_characters = /[^a-zA-Z0-9\-\.\_\~]/
      # Apparently we can't force_encoding on a frozen string since that would
      # modify it. What we can do is work with a copy
      URI.escape(str.dup.to_s.force_encoding(Encoding::UTF_8), reserved_characters)
    end
  end
end
