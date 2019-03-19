module Pesapal
  # Pesapal helper modules.
  module Helper
    # Contains helper methods relating to any queries for payment details. See
    # {Pesapal::Merchant#query_payment_details} source.
    module Details
      # Prepares parameters to be used during the QueryPaymentDetails oAuth 1.0
      # call.
      #
      # The QueryPaymentDetails oAuth 1.0 call requires the following
      # parameters;
      #
      # 1. `oauth_consumer_key` - your Pesapal consumer key sent to you via email or obtained from the dashboard
      # 2. `oauth_nonce` - a random string, uniquely generated for each request. See [section 8 of the oAuth 1.0 spec][3]
      # 3. `oauth_signature` - the signature as defined in the oAuth 1.0 spec under [section 9 of the oAuth 1.0 spec][2]
      # 4. `oauth_signature_method` - `HMAC-SHA1` (do not change). See [section 9.2 of the oAuth 1.0 spec][1]
      # 5. `oauth_timestamp` - number of seconds since January 1, 1970 00:00:00 GMT, also known as Unix Time. See [section 8 of the oAuth 1.0 spec][3]
      # 6. `oauth_version` - `1.0` (do not change)
      # 7. `pesapal_merchant_reference` - the transaction merchant reference (same as `merchant_reference` defined below)
      # 8. `pesapal_transaction_tracking_id` - the transaction tracking id (same as `transaction_tracking_id` defined below)
      #
      # This method generates all the above **except** the `oauth_signature`
      # which is generated later by {Pesapal::Oauth.generate_oauth_signature}
      # since generation of this `oauth_signature` requires these parameters as
      # inputs anyway. See [section 9.2.1 of the oAuth 1.0 spec][1] for more
      # details.
      #
      # [1]: http://oauth.net/core/1.0/#anchor16
      # [2]: http://oauth.net/core/1.0/#signing_process
      # [3]: http://oauth.net/core/1.0/#nonce
      # [4]: http://oauth.net/core/1.0/
      #
      # @param consumer_key [String] your Pesapal consumer key sent to you via
      #   email or obtained from the dashboard
      #
      # @param merchant_reference [String] the unique id generated for the
      #   transaction by your application before posting the order
      #
      # @param transaction_tracking_id [String] the unique id assigned by Pesapal
      #   to the transaction after it's posted
      #
      # @return [Hash] parameters to be used in generating the oAuth 1.0 URL
      #   query parameters and the `oauth_signature` itself.
      def self.set_parameters(consumer_key, merchant_reference, transaction_tracking_id)
        timestamp = Time.now.to_i.to_s

        {
          oauth_consumer_key: consumer_key,
          oauth_nonce: timestamp + Pesapal::Oauth.generate_nonce(12),
          oauth_signature_method: 'HMAC-SHA1',
          oauth_timestamp: timestamp,
          oauth_version: '1.0',
          pesapal_merchant_reference: merchant_reference,
          pesapal_transaction_tracking_id: transaction_tracking_id
        }
      end
    end
  end
end
