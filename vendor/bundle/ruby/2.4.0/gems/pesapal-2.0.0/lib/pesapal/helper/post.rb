module Pesapal
  # Pesapal helper modules.
  module Helper
    # Contains helper methods relating to posting orders. See
    # {Pesapal::Merchant#generate_order_url} source.
    #
    # _For your information;_ the schema below may be used to validate the XML
    # required by Pesapal. You don't have to do this since
    # {Pesapal::Helper::Post.generate_post_xml} pretty much does it for you ... but it's
    # worth noting that the {Pesapal::Helper::Post.generate_post_xml} method only builds a
    # very basic XML structure and is not as comprehensive as the one below. Maybe
    # in the future we might need to add more functionality but as of now it's
    # seems to meet most user's needs.
    #
    # ```xml
    # <!--?xml version="1.0" encoding="utf-8" ?-->
    # <xs:schema xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    #            xmlns:xs="http://www.w3.org/2001/XMLSchema" attributeformdefault="unqualified" elementformdefault="qualified"
    #            targetnamespace="http://www.pesapal.com">
    #   <xsd:element name="PesapalDirectOrderInfo">
    #     <xsd:complextype>
    #       <xsd:sequence>
    #         <xsd:element name="LineItems" minoccurs="0" maxoccurs="1">
    #           <xsd:complextype>
    #             <xsd:sequence>
    #               <xsd:element minoccurs="1" maxoccurs="unbounded" name="LineItem">
    #                 <xsd:complextype>
    #                   <xsd:attribute name="UniqueId"    type="xsd:string"       use="required"></xsd:attribute>
    #                   <xsd:attribute name="Particulars" type="xsd:string"       use="required"></xsd:attribute>
    #                   <xsd:attribute name="Quantity"    type="xsd:unsignedInt"  use="required"></xsd:attribute>
    #                   <xsd:attribute name="UnitCost"    type="xsd:decimal"      use="required"></xsd:attribute>
    #                   <xsd:attribute name="SubTotal"    type="xsd:decimal"      use="required"></xsd:attribute>
    #                 </xsd:complextype>
    #               </xsd:element>
    #             </xsd:sequence>
    #           </xsd:complextype>
    #         </xsd:element>
    #       </xsd:sequence>
    #       <xsd:attribute name="Amount" type="xsd:decimal" use="required"></xsd:attribute>
    #       <xsd:attribute name="Currency" use="optional">
    #         <xsd:simpletype>
    #           <xsd:restriction base="xs:string">
    #             <xsd:pattern value="[A-Za-z][A-Za-z][A-Za-z]"></xsd:pattern>
    #           </xsd:restriction>
    #         </xsd:simpletype>
    #       </xsd:attribute>
    #       <xsd:attribute name="Description" type="xsd:string" use="required"></xsd:attribute>
    #       <xsd:attribute name="Type" use="required">
    #         <xsd:simpletype>
    #           <xsd:restriction base="xsd:string">
    #             <xsd:enumeration value="MERCHANT"></xsd:enumeration>
    #             <xsd:enumeration value="ORDER"></xsd:enumeration>
    #           </xsd:restriction>
    #         </xsd:simpletype>
    #       </xsd:attribute>
    #       <xsd:attribute name="Reference"     type="xsd:string" use="required"></xsd:attribute>
    #       <xsd:attribute name="FirstName"     type="xsd:string" use="optional"></xsd:attribute>
    #       <xsd:attribute name="LastName"      type="xsd:string" use="optional"></xsd:attribute>
    #       <xsd:attribute name="Email"         type="xsd:string" use="required"></xsd:attribute>
    #       <xsd:attribute name="PhoneNumber"   type="xsd:string" use="optional"></xsd:attribute>
    #       <xsd:attribute name="AccountNumber" type="xsd:string" use="optional"></xsd:attribute>
    #     </xsd:complextype>
    #   </xsd:element>
    # </xs:schema>
    # ```
    module Post
      # Build XML formated order data to be submitted as part of the PostPesapalDirectOrderV4 oAuth 1.0 call.
      #
      # The expected order details are as follows;
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
      # order_details = {
      #   amount: 1000,
      #   description: 'this is the transaction description',
      #   type: 'MERCHANT',
      #   reference: '808-707-606',
      #   first_name: 'Swaleh',
      #   last_name: 'Mdoe',
      #   email: 'user@example.com',
      #   phonenumber: '+254722222222',
      #   currency: 'KES'
      # }
      # ```
      #
      # See {Pesapal::Merchant#order_details}.
      #
      # @note Make sure **ALL** expected hash attributes are present, the method
      #   assumes they are and no checks are done to certify that this has been
      #   done nor are any fallbacks built in. Also the `:amount` should be a
      #   number, no commas, or else Pesapal will convert the comma to a period (.)
      #   which will result in the incorrect amount for the transaction.
      #
      # @param details [Hash] the order details, see above for details on it's contents.
      #
      # @return [String] encoded XML formated order data.
      def self.generate_post_xml(details)
        post_xml = ''
        post_xml.concat '<?xml version="1.0" encoding="utf-8"?>'
        post_xml.concat '<PesapalDirectOrderInfo '
        post_xml.concat 'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '
        post_xml.concat 'xmlns:xsd="http://www.w3.org/2001/XMLSchema" '
        post_xml.concat "Amount=\"#{details[:amount]}\" "
        post_xml.concat "Description=\"#{details[:description]}\" "
        post_xml.concat "Type=\"#{details[:type]}\" "
        post_xml.concat "Reference=\"#{details[:reference]}\" "
        post_xml.concat "FirstName=\"#{details[:first_name]}\" "
        post_xml.concat "LastName=\"#{details[:last_name]}\" "
        post_xml.concat "Email=\"#{details[:email]}\" "
        post_xml.concat "PhoneNumber=\"#{details[:phonenumber]}\" "
        post_xml.concat "Currency=\"#{details[:currency]}\" "
        post_xml.concat 'xmlns="http://www.pesapal.com" />'

        # Encode the XML
        encoder = HTMLEntities.new(:xhtml1)
        encoder.encode post_xml
      end

      # Prepares parameters to be used during the PostPesapalDirectOrderV4 oAuth 1.0 call.
      #
      # The PostPesapalDirectOrderV4 oAuth 1.0 call requires the following parameters;
      #
      # 1. `oauth_callback` - URL on your site where the users will be redirected to. See [section 6.2.3 of the oAuth 1.0 spec][5]
      # 2. `oauth_consumer_key` - your Pesapal consumer key sent to you via email or obtained from the dashboard
      # 3. `oauth_nonce` - a random string, uniquely generated for each request. See [section 8 of the oAuth 1.0 spec][3]
      # 4. `oauth_signature` - the signature as defined in the oAuth 1.0 spec under [section 9 of the oAuth 1.0 spec][2]
      # 5. `oauth_signature_method` - `HMAC-SHA1` (do not change). See [section 9.2 of the oAuth 1.0 spec][1]
      # 6. `oauth_timestamp` - number of seconds since January 1, 1970 00:00:00 GMT, also known as Unix Time. See [section 8 of the oAuth 1.0 spec][3]
      # 7. `oauth_version` - `1.0` (do not change)
      # 8. `pesapal_request_data` - encoded XML formated order data (same as `post_xml` defined below).
      #
      # This method generates all the above **except** the `oauth_signature` which
      # is generated later by {Pesapal::Oauth.generate_oauth_signature} since
      # generation of this `oauth_signature` requires these parameters as inputs
      # anyway. See [section 9.2.1 of the oAuth 1.0 spec][1] for more details.
      #
      # [1]: http://oauth.net/core/1.0/#anchor16
      # [2]: http://oauth.net/core/1.0/#signing_process
      # [3]: http://oauth.net/core/1.0/#nonce
      # [4]: http://oauth.net/core/1.0/
      # [5]: http://oauth.net/core/1.0/#auth_step2
      #
      # @param callback_url [String] URL to the redirect page. This is the page on
      #   your site where the users will be redirected to, after they have made the
      #   payment on PesaPal.
      #
      # @param consumer_key [String] your Pesapal consumer key sent to you via
      #   email or obtained from the dashboard
      #
      # @param post_xml [String] encoded XML formated order data. Generated by {generate_post_xml}
      #
      # @return [Hash] parameters to be used in generating the oAuth 1.0 URL query parameters and the `oauth_signature` itself.
      def self.set_parameters(callback_url, consumer_key, post_xml)
        timestamp = Time.now.to_i.to_s

        {
          oauth_callback: callback_url,
          oauth_consumer_key: consumer_key,
          oauth_nonce: timestamp + Pesapal::Oauth.generate_nonce(12),
          oauth_signature_method: 'HMAC-SHA1',
          oauth_timestamp: timestamp,
          oauth_version: '1.0',
          pesapal_request_data: post_xml
        }
      end
    end
  end
end
