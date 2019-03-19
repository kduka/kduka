require 'spec_helper'

describe Pesapal::Merchant do
  let(:order_details) do
    {
      amount: 1000,
      description: Faker::Lorem.sentence,
      type: 'MERCHANT',
      reference: '111-222-333',
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      phonenumber: Faker::PhoneNumber.phone_number,
      currency: 'KES' # ['USD', 'KES', 'UGX', 'TZA'].sample
    }
  end

  let(:default_credentials) do
    {
      callback_url: 'http://0.0.0.0:3000/pesapal/callback',
      consumer_key: '<YOUR_CONSUMER_KEY>',
      consumer_secret: '<YOUR_CONSUMER_SECRET>'
    }
  end

  context 'when mode not specified' do
    let(:pesapal) { Pesapal::Merchant.new }

    describe '#new' do
      it 'is valid object' do
        expect(pesapal).to be_an_instance_of(Pesapal::Merchant)
      end

      it 'sets default environment variable' do
        expect(pesapal.send(:env)).to eq 'development'
      end

      it 'sets default credentials' do
        expect(pesapal.config).to eq(default_credentials)
      end

      it 'sets default order details' do
        expect(pesapal.order_details).to eq({})
      end
    end

    describe '#generate_order_url' do
      it 'generates iframe url string' do
        pesapal.order_details = order_details
        expect(pesapal.generate_order_url).to match %r{https://demo.pesapal.com/API/PostPesapalDirectOrderV4\?oauth_callback=.*oauth_consumer_key=.*oauth_nonce=.*oauth_signature=.*oauth_signature_method=HMAC-SHA1&oauth_timestamp.*oauth_version=1.0&pesapal_request_data=.*}
      end
    end

    describe '#query_payment_status' do
      let(:request) { stub_request(:get, %r{https://demo.pesapal.com/API/QueryPaymentStatus\?oauth_consumer_key=.*oauth_nonce=.*oauth_signature=.*oauth_signature_method=HMAC-SHA1&oauth_timestamp.*oauth_version=1.0&pesapal_merchant_reference=.*&pesapal_transaction_tracking_id=.*}) }

      it 'gets pending payment status' do
        request.to_return(status: 200, body: 'pesapal_response_data=PENDING')
        expect(pesapal.query_payment_status('merchant_reference', 'transaction_tracking_id')).to eq('PENDING')
      end

      it 'gets completed payment status' do
        request.to_return(status: 200, body: 'pesapal_response_data=COMPLETED')
        expect(pesapal.query_payment_status('merchant_reference', 'transaction_tracking_id')).to eq('COMPLETED')
      end

      it 'gets failed payment status' do
        request.to_return(status: 200, body: 'pesapal_response_data=FAILED')
        expect(pesapal.query_payment_status('merchant_reference', 'transaction_tracking_id')).to eq('FAILED')
      end

      it 'gets invalid payment status' do
        request.to_return(status: 200, body: 'pesapal_response_data=INVALID')
        expect(pesapal.query_payment_status('merchant_reference', 'transaction_tracking_id')).to eq('INVALID')
      end
    end

    describe '#query_payment_details' do
      let(:request) { stub_request(:get, %r{https://demo.pesapal.com/API/QueryPaymentDetails\?oauth_consumer_key=.*oauth_nonce=.*oauth_signature=.*oauth_signature_method=HMAC-SHA1&oauth_timestamp.*oauth_version=1.0&pesapal_merchant_reference=.*&pesapal_transaction_tracking_id=.*}) }

      it 'gets pending payment details' do
        request.to_return(status: 200, body: 'pesapal_response_data=transaction_tracking_id,payment_method,payment_status,merchant_reference')
        expected_result = {
          method: 'payment_method',
          status: 'payment_status',
          merchant_reference: 'merchant_reference',
          transaction_tracking_id: 'transaction_tracking_id'
        }
        expect(pesapal.query_payment_details('merchant_reference', 'transaction_tracking_id')).to eq(expected_result)
      end
    end

    describe '#ipn_listener' do
      let(:request) { stub_request(:get, %r{https://demo.pesapal.com/API/QueryPaymentStatus\?oauth_consumer_key=.*oauth_nonce=.*oauth_signature=.*oauth_signature_method=HMAC-SHA1&oauth_timestamp.*oauth_version=1.0&pesapal_merchant_reference=.*&pesapal_transaction_tracking_id=.*}) }

      it 'gets ipn response for pending status' do
        request.to_return(status: 200, body: 'pesapal_response_data=PENDING')
        expect(pesapal.ipn_listener('CHANGE', 'merchant_reference', 'transaction_tracking_id')).to eq(status: 'PENDING', response: nil)
      end

      it 'gets ipn response for completed status' do
        request.to_return(status: 200, body: 'pesapal_response_data=COMPLETED')
        expect(pesapal.ipn_listener('CHANGE', 'merchant_reference', 'transaction_tracking_id')).to eq(status: 'COMPLETED', response: 'pesapal_notification_type=CHANGE&pesapal_transaction_tracking_id=transaction_tracking_id&pesapal_merchant_reference=merchant_reference')
      end

      it 'gets ipn response for failed status' do
        request.to_return(status: 200, body: 'pesapal_response_data=FAILED')
        expect(pesapal.ipn_listener('CHANGE', 'merchant_reference', 'transaction_tracking_id')).to eq(status: 'FAILED', response: 'pesapal_notification_type=CHANGE&pesapal_transaction_tracking_id=transaction_tracking_id&pesapal_merchant_reference=merchant_reference')
      end

      it 'gets ipn response for invalid status' do
        request.to_return(status: 200, body: 'pesapal_response_data=INVALID')
        expect(pesapal.ipn_listener('CHANGE', 'merchant_reference', 'transaction_tracking_id')).to eq(status: 'INVALID', response: nil)
      end
    end
  end

  context 'when mode is specified as development' do
    let(:pesapal) { Pesapal::Merchant.new(:development) }

    describe '#new(:development)' do
      it 'is valid object' do
        expect(pesapal).to be_an_instance_of(Pesapal::Merchant)
      end

      it 'sets environment variable' do
        expect(pesapal.send(:env)).to eq 'development'
      end

      it 'sets credentials' do
        expect(pesapal.config).to eq(default_credentials)
      end

      it 'sets order details' do
        expect(pesapal.order_details).to eq({})
      end
    end

    describe '#generate_order_url' do
      it 'generates iframe url string' do
        pesapal.order_details = order_details
        expect(pesapal.generate_order_url).to match %r{https://demo.pesapal.com/API/PostPesapalDirectOrderV4\?oauth_callback=.*oauth_consumer_key=.*oauth_nonce=.*oauth_signature=.*oauth_signature_method=HMAC-SHA1&oauth_timestamp.*oauth_version=1.0&pesapal_request_data=.*}
      end
    end

    describe '#query_payment_status' do
      let(:request) { stub_request(:get, %r{https://demo.pesapal.com/API/QueryPaymentStatus\?oauth_consumer_key=.*oauth_nonce=.*oauth_signature=.*oauth_signature_method=HMAC-SHA1&oauth_timestamp.*oauth_version=1.0&pesapal_merchant_reference=.*&pesapal_transaction_tracking_id=.*}) }

      it 'gets pending payment status' do
        request.to_return(status: 200, body: 'pesapal_response_data=PENDING')
        expect(pesapal.query_payment_status('merchant_reference', 'transaction_tracking_id')).to eq('PENDING')
      end

      it 'gets completed payment status' do
        request.to_return(status: 200, body: 'pesapal_response_data=COMPLETED')
        expect(pesapal.query_payment_status('merchant_reference', 'transaction_tracking_id')).to eq('COMPLETED')
      end

      it 'gets failed payment status' do
        request.to_return(status: 200, body: 'pesapal_response_data=FAILED')
        expect(pesapal.query_payment_status('merchant_reference', 'transaction_tracking_id')).to eq('FAILED')
      end

      it 'gets invalid payment status' do
        request.to_return(status: 200, body: 'pesapal_response_data=INVALID')
        expect(pesapal.query_payment_status('merchant_reference', 'transaction_tracking_id')).to eq('INVALID')
      end
    end

    describe '#query_payment_details' do
      let(:request) { stub_request(:get, %r{https://demo.pesapal.com/API/QueryPaymentDetails\?oauth_consumer_key=.*oauth_nonce=.*oauth_signature=.*oauth_signature_method=HMAC-SHA1&oauth_timestamp.*oauth_version=1.0&pesapal_merchant_reference=.*&pesapal_transaction_tracking_id=.*}) }

      it 'gets pending payment details' do
        request.to_return(status: 200, body: 'pesapal_response_data=transaction_tracking_id,payment_method,payment_status,merchant_reference')
        expected_result = {
          method: 'payment_method',
          status: 'payment_status',
          merchant_reference: 'merchant_reference',
          transaction_tracking_id: 'transaction_tracking_id'
        }
        expect(pesapal.query_payment_details('merchant_reference', 'transaction_tracking_id')).to eq(expected_result)
      end
    end

    describe '#ipn_listener' do
      let(:request) { stub_request(:get, %r{https://demo.pesapal.com/API/QueryPaymentStatus\?oauth_consumer_key=.*oauth_nonce=.*oauth_signature=.*oauth_signature_method=HMAC-SHA1&oauth_timestamp.*oauth_version=1.0&pesapal_merchant_reference=.*&pesapal_transaction_tracking_id=.*}) }

      it 'gets ipn response for pending status' do
        request.to_return(status: 200, body: 'pesapal_response_data=PENDING')
        expect(pesapal.ipn_listener('CHANGE', 'merchant_reference', 'transaction_tracking_id')).to eq(status: 'PENDING', response: nil)
      end

      it 'gets ipn response for completed status' do
        request.to_return(status: 200, body: 'pesapal_response_data=COMPLETED')
        expect(pesapal.ipn_listener('CHANGE', 'merchant_reference', 'transaction_tracking_id')).to eq(status: 'COMPLETED', response: 'pesapal_notification_type=CHANGE&pesapal_transaction_tracking_id=transaction_tracking_id&pesapal_merchant_reference=merchant_reference')
      end

      it 'gets ipn response for failed status' do
        request.to_return(status: 200, body: 'pesapal_response_data=FAILED')
        expect(pesapal.ipn_listener('CHANGE', 'merchant_reference', 'transaction_tracking_id')).to eq(status: 'FAILED', response: 'pesapal_notification_type=CHANGE&pesapal_transaction_tracking_id=transaction_tracking_id&pesapal_merchant_reference=merchant_reference')
      end

      it 'gets ipn response for invalid status' do
        request.to_return(status: 200, body: 'pesapal_response_data=INVALID')
        expect(pesapal.ipn_listener('CHANGE', 'merchant_reference', 'transaction_tracking_id')).to eq(status: 'INVALID', response: nil)
      end
    end
  end

  context 'when mode is specified as production' do
    let(:pesapal) { Pesapal::Merchant.new(:production) }

    describe '#new(:production)' do
      it 'is valid object' do
        expect(pesapal).to be_an_instance_of(Pesapal::Merchant)
      end

      it 'sets environment variable' do
        expect(pesapal.send(:env)).to eq 'production'
      end

      it 'sets credentials' do
        expect(pesapal.config).to eq(default_credentials)
      end

      it 'sets order details' do
        expect(pesapal.order_details).to eq({})
      end
    end

    describe '#generate_order_url' do
      it 'generates iframe url string' do
        pesapal.order_details = order_details
        expect(pesapal.generate_order_url).to match %r{https://www.pesapal.com/API/PostPesapalDirectOrderV4\?oauth_callback=.*oauth_consumer_key=.*oauth_nonce=.*oauth_signature=.*oauth_signature_method=HMAC-SHA1&oauth_timestamp.*oauth_version=1.0&pesapal_request_data=.*}
      end
    end

    describe '#query_payment_status' do
      let(:request) { stub_request(:get, %r{https://www.pesapal.com/API/QueryPaymentStatus\?oauth_consumer_key=.*oauth_nonce=.*oauth_signature=.*oauth_signature_method=HMAC-SHA1&oauth_timestamp.*oauth_version=1.0&pesapal_merchant_reference=.*&pesapal_transaction_tracking_id=.*}) }

      it 'gets pending payment status' do
        request.to_return(status: 200, body: 'pesapal_response_data=PENDING')
        expect(pesapal.query_payment_status('merchant_reference', 'transaction_tracking_id')).to eq('PENDING')
      end

      it 'gets completed payment status' do
        request.to_return(status: 200, body: 'pesapal_response_data=COMPLETED')
        expect(pesapal.query_payment_status('merchant_reference', 'transaction_tracking_id')).to eq('COMPLETED')
      end

      it 'gets failed payment status' do
        request.to_return(status: 200, body: 'pesapal_response_data=FAILED')
        expect(pesapal.query_payment_status('merchant_reference', 'transaction_tracking_id')).to eq('FAILED')
      end

      it 'gets invalid payment status' do
        request.to_return(status: 200, body: 'pesapal_response_data=INVALID')
        expect(pesapal.query_payment_status('merchant_reference', 'transaction_tracking_id')).to eq('INVALID')
      end
    end

    describe '#query_payment_details' do
      let(:request) { stub_request(:get, %r{https://www.pesapal.com/API/QueryPaymentDetails\?oauth_consumer_key=.*oauth_nonce=.*oauth_signature=.*oauth_signature_method=HMAC-SHA1&oauth_timestamp.*oauth_version=1.0&pesapal_merchant_reference=.*&pesapal_transaction_tracking_id=.*}) }

      it 'gets pending payment details' do
        request.to_return(status: 200, body: 'pesapal_response_data=transaction_tracking_id,payment_method,payment_status,merchant_reference')
        expected_result = {
          method: 'payment_method',
          status: 'payment_status',
          merchant_reference: 'merchant_reference',
          transaction_tracking_id: 'transaction_tracking_id'
        }
        expect(pesapal.query_payment_details('merchant_reference', 'transaction_tracking_id')).to eq(expected_result)
      end
    end

    describe '#ipn_listener' do
      let(:request) { stub_request(:get, %r{https://www.pesapal.com/API/QueryPaymentStatus\?oauth_consumer_key=.*oauth_nonce=.*oauth_signature=.*oauth_signature_method=HMAC-SHA1&oauth_timestamp.*oauth_version=1.0&pesapal_merchant_reference=.*&pesapal_transaction_tracking_id=.*}) }

      it 'gets ipn response for pending status' do
        request.to_return(status: 200, body: 'pesapal_response_data=PENDING')
        expect(pesapal.ipn_listener('CHANGE', 'merchant_reference', 'transaction_tracking_id')).to eq(status: 'PENDING', response: nil)
      end

      it 'gets ipn response for completed status' do
        request.to_return(status: 200, body: 'pesapal_response_data=COMPLETED')
        expect(pesapal.ipn_listener('CHANGE', 'merchant_reference', 'transaction_tracking_id')).to eq(status: 'COMPLETED', response: 'pesapal_notification_type=CHANGE&pesapal_transaction_tracking_id=transaction_tracking_id&pesapal_merchant_reference=merchant_reference')
      end

      it 'gets ipn response for failed status' do
        request.to_return(status: 200, body: 'pesapal_response_data=FAILED')
        expect(pesapal.ipn_listener('CHANGE', 'merchant_reference', 'transaction_tracking_id')).to eq(status: 'FAILED', response: 'pesapal_notification_type=CHANGE&pesapal_transaction_tracking_id=transaction_tracking_id&pesapal_merchant_reference=merchant_reference')
      end

      it 'gets ipn response for invalid status' do
        request.to_return(status: 200, body: 'pesapal_response_data=INVALID')
        expect(pesapal.ipn_listener('CHANGE', 'merchant_reference', 'transaction_tracking_id')).to eq(status: 'INVALID', response: nil)
      end
    end
  end
end
