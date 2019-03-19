module Pesapal
  # Pesapal Merchant object responsible for posting and handling transaction
  # queries.
  class Merchant
    attr_accessor :config, :order_details

    # Holds configuration details for the Pesapal object.
    #
    # 1. `:callback_url` - the page on your site that users will be redirected to, after they have made the payment on PesaPal
    # 2. `:consumer_key` - your Pesapal consumer key sent to you via email or obtained from the dashboard
    # 3. `:consumer_secret` - your Pesapal consumer secret sent to you via email or obtained from the dashboard
    #
    # It typically looks like this:
    #
    # ```
    # {  :callback_url => 'http://0.0.0.0:3000/pesapal/callback',
    #    :consumer_key => '<YOUR_CONSUMER_KEY>',
    #    :consumer_secret => '<YOUR_CONSUMER_SECRET>'
    # }
    # ```
    #
    # @return [Hash] the Pesapal config
    def config
      @config ||= {}
    end

    # Holds the order details for the transaction.
    #
    # 1. `:amount` - the order amount
    # 2. `:description` - a note about the order
    # 3. `:type` - MERCHANT
    # 4. `:reference` - the unique id generated for the transaction by your application before posting the order
    # 5. `:first_name` - first name of the customer
    # 6. `:last_name` - second name of the customer
    # 7. `:email` - email of the customer
    # 8. `:phonenumber` - phone number of the customer
    # 9. `:currency` - ISO code for the currency
    #
    # It typically looks like this:
    #
    # ```
    # { :amount => 1000,
    #   :description => 'this is the transaction description',
    #   :type => 'MERCHANT',
    #   :reference => '808-707-606',
    #   :first_name => 'Swaleh',
    #   :last_name => 'Mdoe',
    #   :email => 'user@example.com',
    #   :phonenumber => '+254722222222',
    #   :currency => 'KES'
    # }
    # ```
    #
    # @note Make sure **ALL** expected hash attributes are present, the method
    #   assumes they are and no checks are done to certify that this has been
    #   done nor are any fallbacks built in. Also the `:amount` should be a
    #   number, no commas, or else Pesapal will convert the comma to a period (.)
    #   which will result in the incorrect amount for the transaction.
    #
    # @return [Hash] the order details
    def order_details
      @order_details ||= {}
    end

    private

    attr_reader :env

    def params
      @params ||= nil
    end

    def post_xml
      @post_xml ||= nil
    end

    def token_secret
      @token_secret ||= nil
    end

    public

    # Creates a new instance of {Pesapal::Merchant}.
    #
    # Initialize Pesapal object and choose the environment, there are two
    # environments; `:development` and `:production`. They determine if the code
    # will interact with the testing or the live Pesapal API. Like so ...
    #
    # ```ruby
    # # Sets environment to :development explicitly
    # pesapal = Pesapal::Merchant.new(:development)
    #
    # # Sets environment to :production
    # pesapal = Pesapal::Merchant.new(:production)
    # ```
    #
    # @param env [Symbol] the environment we want to use i.e. `:development` or
    #   `:production`.
    def initialize(env = :development)
      @env = env.to_s.downcase
      @config = {
        callback_url: 'http://0.0.0.0:3000/pesapal/callback',
        consumer_key: '<YOUR_CONSUMER_KEY>',
        consumer_secret: '<YOUR_CONSUMER_SECRET>'
      }
    end

    # Generate URL that's used to post a transaction to PesaPal.
    #
    # PesaPal will present the user with a page which contains the available
    # payment options and will redirect to your site to the _callback url_ once
    # the user has completed the payment process. A tracking id will be returned
    # as a query parameter - this can be used subsequently to track the payment
    # status on Pesapal for the transaction later on.
    #
    # Generating the URL is a 3-step process:
    #
    # 1. Initialize {Pesapal::Merchant}, making sure credentials are set. See {#initialize} for details.
    # 2. Set the order details. See {#order_details} for details.
    # 3. Call {#generate_order_url} on the object.
    #
    # Example:
    #
    # ```ruby
    # # generate transaction url after step #1 & #2
    # order_url = pesapal.generate_order_url
    #
    # # order_url now contains a string with the order url.
    # # http://demo.pesapal.com/API/PostPesapalDirectOrderV4?oauth_callback=http%3A%2F%2F1.2.3.4%3A3000%2Fpesapal%2Fcallback&oauth_consumer_key=A9MXocJiHK1P4w0M%2F%2FYzxgIVMX557Jt4&oauth_nonce=13804335543pDXs4q3djsy&oauth_signature=BMmLR0AVInfoBI9D4C38YDA9eSM%3D&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1380433554&oauth_version=1.0&pesapal_request_data=%26lt%3B%3Fxml%20version%3D%26quot%3B1.0%26quot%3B%20encoding%3D%26quot%3Butf-8%26quot%3B%3F%26gt%3B%26lt%3BPesapalDirectOrderInfo%20xmlns%3Axsi%3D%26quot%3Bhttp%3A%2F%2Fwww.w3.org%2F2001%2FXMLSchema-instance%26quot%3B%20xmlns%3Axsd%3D%26quot%3Bhttp%3A%2F%2Fwww.w3.org%2F2001%2FXMLSchema%26quot%3B%20Amount%3D%26quot%3B1000%26quot%3B%20Description%3D%26quot%3Bthis%20is%20the%20transaction%20description%26quot%3B%20Type%3D%26quot%3BMERCHANT%26quot%3B%20Reference%3D%26quot%3B808%26quot%3B%20FirstName%3D%26quot%3BSwaleh%26quot%3B%20LastName%3D%26quot%3BMdoe%26quot%3B%20Email%3D%26quot%3Bj%40kingori.co%26quot%3B%20PhoneNumber%3D%26quot%3B%2B254722222222%26quot%3B%20xmlns%3D%26quot%3Bhttp%3A%2F%2Fwww.pesapal.com%26quot%3B%20%2F%26gt%3B
    # ```
    #
    # @note You **MUST** set up your order details before you call this method on the object.
    #
    # @return [String] URL of the Pesapal post order form
    def generate_order_url
      # build xml with input data, the format is standard so no editing is
      # required
      @post_xml = Pesapal::Helper::Post.generate_post_xml @order_details
      # initialize setting of @params (oauth_signature left empty)
      @params = Pesapal::Helper::Post.set_parameters(@config[:callback_url], @config[:consumer_key], @post_xml)
      # generate oauth signature and add signature to the request parameters
      @params[:oauth_signature] = Pesapal::Oauth.generate_oauth_signature(
        'GET',
        postpesapaldirectorderv4_url,
        @params,
        @config[:consumer_secret],
        @token_secret
      )
      # change params (with signature) to a query string
      query_string = Pesapal::Oauth.generate_encoded_params_query_string @params

      "#{postpesapaldirectorderv4_url}?#{query_string}"
    end

    # Same as {#query_payment_status}, but additional information is returned in
    # a Hash.
    #
    # Call method on initialized {Pesapal::Merchant} object (see {#initialize}
    # for details):
    #
    # ```ruby
    # # pass in merchant reference and transaction id
    # payment_details = pesapal.query_payment_details("<MERCHANT_REFERENCE>","<TRANSACTION_ID>")
    # ```
    #
    # Response should contain the following:
    #
    # 1. `:method` - the payment method used by the user to make the payment
    # 2. `:status` - one of `PENDING | COMPLETED | FAILED | INVALID`
    # 3. `:merchant_reference` - this is the same as the parameter you sent when making the query
    # 4. `:transaction_tracking_id` - this is the same as the parameter you sent when making the query
    #
    # Example:
    #
    # ```
    # {
    #   :method => "<PAYMENT_METHOD>",
    #   :status => "<PAYMENT_STATUS>",
    #   :merchant_reference => "<MERCHANT_REFERENCE>",
    #   :transaction_tracking_id => "<TRANSACTION_ID>"
    # }
    # ```
    #
    # @param merchant_reference [String] the unique id generated for the
    #   transaction by your application before posting the order
    #
    # @param transaction_tracking_id [String] the unique id assigned by Pesapal
    #   to the transaction after it's posted
    #
    # @return [Hash] transaction payment details
    def query_payment_details(merchant_reference, transaction_tracking_id)
      # initialize setting of @params (oauth_signature left empty)
      @params = Pesapal::Helper::Details.set_parameters(@config[:consumer_key], merchant_reference, transaction_tracking_id)
      # generate oauth signature and add signature to the request parameters
      @params[:oauth_signature] = Pesapal::Oauth.generate_oauth_signature(
        'GET',
        querypaymentdetails_url,
        @params,
        @config[:consumer_secret],
        @token_secret
      )
      # change params (with signature) to a query string
      query_string = Pesapal::Oauth.generate_encoded_params_query_string @params

      # get status response
      uri = URI.parse "#{querypaymentdetails_url}?#{query_string}"
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      response = http.request(Net::HTTP::Get.new(uri.request_uri))
      response = CGI.parse response.body
      response = response['pesapal_response_data'][0].split(',')

      {
        method: response[1],
        status: response[2],
        merchant_reference: response[3],
        transaction_tracking_id: response[0]
      }
    end

    # Query the status of a transaction.
    #
    # When a transaction is posted to PesaPal, it may be in a `PENDING`,
    # `COMPLETED` or `FAILED` state. If the transaction is `PENDING`, the
    # payment may complete or fail at a later stage.
    #
    # ```ruby
    # # option 1: using merchant reference only
    # payment_status = pesapal.query_payment_status("<MERCHANT_REFERENCE>")
    #
    # # option 2: using merchant reference and transaction id (recommended, see note for reason why)
    # payment_status = pesapal.query_payment_status("<MERCHANT_REFERENCE>","<TRANSACTION_ID>")
    # ```
    #
    # @note If you don't ensure that the merchant reference is unique for each
    #   order on your system, you may get INVALID as the response. Because of
    #   this, it is recommended that you provide both the merchant reference and
    #   transaction tracking id as parameters to guarantee uniqueness.
    #
    # @param merchant_reference [String] the unique id generated for the
    #   transaction by your application before posting the order
    #
    # @param transaction_tracking_id [String] the unique id assigned by Pesapal
    #   to the transaction after it's posted
    #
    # @return [String] the status of the transaction. Possible values include
    #   PENDING | COMPLETED | FAILED | INVALID
    def query_payment_status(merchant_reference, transaction_tracking_id = nil)
      # initialize setting of @params (oauth_signature left empty)
      @params = Pesapal::Helper::Status.set_parameters(@config[:consumer_key], merchant_reference, transaction_tracking_id)
      # generate oauth signature and add signature to the request parameters
      @params[:oauth_signature] = Pesapal::Oauth.generate_oauth_signature(
        'GET',
        querypaymentstatus_url,
        @params,
        @config[:consumer_secret],
        @token_secret
      )
      # change params (with signature) to a query string
      query_string = Pesapal::Oauth.generate_encoded_params_query_string @params

      # get status response
      uri = URI.parse "#{querypaymentstatus_url}?#{query_string}"
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      response = http.request(Net::HTTP::Get.new(uri.request_uri))
      response = CGI.parse response.body
      response['pesapal_response_data'][0]
    end

    # Generates the appropriate IPN response depending on the status of the
    # transaction.
    #
    # ```ruby
    # # pass in the notification type, merchant reference and transaction id
    # response_to_ipn = pesapal.ipn_listener("<NOTIFICATION_TYPE>", "<MERCHANT_REFERENCE>","<TRANSACTION_ID>")
    # ```
    #
    # The variable, `response_to_ipn`, now holds a response as the one shown
    # below. Using the status you can customise any actions (e.g. database
    # inserts and updates).
    #
    # ```
    # {
    #   :status => "<PAYMENT_STATUS>",
    #   :response => "<IPN_RESPONSE>"
    # }
    # ```
    #
    # _Ps: The response you send to PesaPal must be the same as what you
    # received from PesaPal if successful, which the method generates for you
    # and should be in `:response`._
    #
    # @note It's up to you to send the response back to Pesapal by providing the
    #   `:response` back to the IPN. The hard part is done.
    #
    # @param notification_type [String] the IPN notification type, overridden
    #   and set to CHANGE internally. Left here for extensibility.
    #
    # @param merchant_reference [String] the unique id generated for the
    #   transaction by your application before posting the order
    #
    # @param transaction_tracking_id [String] the unique id assigned by Pesapal
    #   to the transaction after it's posted
    #
    # @return [Hash] contains the status and IPN response that should be sent
    #   back to Pesapal
    def ipn_listener(notification_type, merchant_reference, transaction_tracking_id)
      notification_type = 'CHANGE'
      status = query_payment_status(merchant_reference, transaction_tracking_id)
      output = { status: status, response: nil }

      response = "pesapal_notification_type=#{notification_type}"
      response += "&pesapal_transaction_tracking_id=#{transaction_tracking_id}"
      response += "&pesapal_merchant_reference=#{merchant_reference}"

      case status
      when 'COMPLETED' then output[:response] = response
      when 'FAILED'    then output[:response] = response
      end

      output
    end

    private

    def api_domain
      @env == 'production' ? 'www.pesapal.com' : 'demo.pesapal.com'
    end

    def api_endpoint
      'https://' + api_domain
    end

    def postpesapaldirectorderv4_url
      api_endpoint + '/API/PostPesapalDirectOrderV4'
    end

    def querypaymentstatus_url
      api_endpoint + '/API/QueryPaymentStatus'
    end

    def querypaymentdetails_url
      api_endpoint + '/API/QueryPaymentDetails'
    end
  end
end
