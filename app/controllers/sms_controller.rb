class SmsController < ApplicationController
  require 'AfricasTalking'
  require 'date'

  now = Date.today

        if Rails.env.production?
          username = "#{ENV['AT_USER']}";
          apikey = "#{ENV['AT_KEY']}";
        else
          username = "kduka";
          apikey = "c44856da2978476f3745584c9a070df8501c9d66cf44a993d07ef35c68fb3329";
        end

        AT = AfricasTalking::Initialize.new username, apikey

    def client_sms(o,state)
      o=@order
      to = o.phone
      if state = 0
      message = "Your payment of Ksh:#{@order.amount_received} to #{@store.name} has been received for the order #{@order.ref}. Please pay Ksh: #{@order.total - @order.amount_received} to complete your order."
      else
      message = "Your payment of Ksh:#{@order.amount_received} to #{@store.name} has been received for the order #{@order.ref}."
      end
      send_sms(to,message)
    end

    def merchant_sms(o,state)
      owner = o.store_id
      to = Store.where(store_id: owner).phone
      if state = 0
        message = "A partial payment of Ksh: #{@order.amount_received} has been received for the order #{@order.ref}. A balance of Ksh: #{@order.total - @order.amount_received} is remaining"
      else
        message = "A payment of Ksh: #{@order.amount_received} has been received for the order #{@order.ref}"
      end
      send_sms(to,message)
    end

    def week_notice(inv,to)

        message = "Your invoice for the period #{inv.from} - #{inv.to} is ready. Please login to your store to make a payment before #{inv.due}."
        send_sms(to,message)

    end

    def final_sms(inv,to)

        message = "Your invoice for the period #{inv.from} - #{inv.to} has not been paid for. Kindly login to your store to make a payment before #{inv.due} to avoid account suspension."
        send_sms(to,message)

    end

    def suspend(inv,to)

      message = "Your store has been suspended because you have an unpaid invoice for the period #{inv.from} - #{inv.to}. Kindly login in to your store and make a payment to continue enjoying our services"
      send_sms(to,message)

    end

    def partial_sub(o)
      to = o.phone
      message = "Your partial payment of Ksh: #{o.received} has been received. Your outstanding balance is Ksh #{o.amount - o.received}."
      send_sms(to,message)
    end

    def confirm_sub(o)
      to = o.phone
      message = "Your payment of Ksh: #{o.received} has been received for #{o.description} subscription. Your store has been restored."
      send_sms(to,message)
    end

    def send_sms(to,message)
      require 'AfricasTalking'

      sms = AT.sms

      options = {
          "to" => to,
          "message" => message,
          "from" => 'KDuka'
          }
        begin
          # Thats it, hit send and we'll take care of the rest.
          reports = sms.send options
          reports.each {|report|
            puts report.to_yaml
            r = report.to_json
            # if r[statusCode] == "403"
            #   SmsLog.info "Message to #{report.number} failed. Check the number."
            # elsif r[statusCode] == "502"
            #   SmsLog.info "Message to #{report.number} failed. A Gateway Error."
            # elsif r[statusCode] == 405
            #   SmsLog.info "Message to #{report.number} failed. Insufficient Balance"
            # end
            }
          rescue AfricasTalking::AfricasTalkingException => ex
            puts 'Encountered an error: ' + ex.message
        end

        # make_post_req(options)
    end

     def callback

    response = request.body.read
    delivery = JSON.parse(response)

    if delivery[status] == "Rejected"
      SmsLog.info "Message #{delivery[id]} delivery to #{delivery[phone]} failed. Reason being #{delivery[failureReason]}"
    elsif delivery[status] == "Failed"
      SmsLog.info "Message #{delivery[id]} delivery to #{delivery[phone]} failed. Reason being #{delivery[failureReason]}"
    end
  end

end
