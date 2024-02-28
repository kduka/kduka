# == Schema Information
#
# Table name: invoices
#
#  id              :integer          not null, primary key
#  amount          :integer
#  currency        :string
#  deliveries      :boolean
#  description     :text
#  due             :date
#  firt_del        :boolean
#  from            :date
#  invoice         :string
#  issued          :date
#  name            :string
#  second_del      :boolean
#  subtotal        :integer
#  tax             :integer
#  to              :date
#  uid             :string
#  url             :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  i_id            :string
#  order_status_id :integer
#  store_id        :integer
#  subscription_id :integer
#
# Indexes
#
#  index_invoices_on_order_status_id  (order_status_id)
#  index_invoices_on_store_id         (store_id)
#  index_invoices_on_subscription_id  (subscription_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_status_id => order_statuses.id)
#  fk_rails_...  (store_id => stores.id)
#  fk_rails_...  (subscription_id => subscriptions.id)
#
class Invoice < ApplicationRecord
  belongs_to :store

  def self.generate
    require 'active_support'
    stores = Store.all

    stores.each do |s|

      puts "Store name: #{s.name.upcase}"

      if s.activatable == false

        puts "skipping deactivated store #{s.name}"

      elsif s.plan_id == 2

        puts "\n Store is premium. \n Total days diff is #{total_days(s.premiumexpiry)}"

        if total_days(s.premiumexpiry) <= 0
          puts "\n disconnecting .. \n"
          disconnect(s)
        elsif total_days(s.premiumexpiry) == 1
          puts "\n Sending final invoice .. \n"
          send_final_invoice(s)
        elsif total_days(s.premiumexpiry) == 7
          puts "\n generating invoice \n"
          generate_invoice(s)
        else
          puts "\n \n Days to premium expiry are more than 7, no criteria matched \n \n "
          #generate_invoice(s)
        end

      elsif s.trial

        puts "\n Trial Store \n"
        puts "Total days to end of trial are #{total_days(s.trial_end)}"

        if total_days(s.trial_end) <= 0
          puts " \n disconnecting trial store"
          disconnect(s)
        elsif total_days(s.trial_end) == 1
          puts "\n sending final invoice trial store"
          send_final_invoice(s)
        elsif total_days(s.trial_end) <= 7
          puts "\n generating invoice for trial store"
          generate_invoice(s)
        else
          puts "\n \n The store #{s.name} has #{total_days(s.trial_end)} left for trial \n \n "
          #generate_invoice(s)
        end
      else
        puts "\n \n This is not a premium store \n \n "

        if total_days(s.premiumexpiry) <= 0
          puts "\n \n DISCONNECTING #{s.name} \n \n "
          disconnect(s)
        elsif total_days(s.premiumexpiry) == 1
          puts "\n \n SENDING INVOICE FOR #{s.name} \n \n "
          send_final_invoice(s)
        elsif total_days(s.premiumexpiry) == 7
          puts "\n \n GENERATING INVOICE FOR #{s.name} \n \n "
          generate_invoice(s)
        else
          puts "\n \n The #{s.name} meets no criteria above. Which means the days to premium expiry are #{total_days(s.premiumexpiry)}\n \n "
          #generate_invoice(s)
        end
      end
    end
  end

  def self.total_days(expiry)
    if expiry.nil?
      expiry = DateTime.now
    end
    difference_in_days = (expiry - Date.today).to_i
  end

  def self.reverse_total_days(issue_day)
    difference_in_days = (Date.today - issue_day).to_i
  end

  def self.generate_invoice(store)

    invoice = Invoice.where(store_id: store.id).last

    puts "Is invoice nil? #{invoice.nil?}, days since last issued invoice are #{reverse_total_days(invoice.issued) rescue nil}"

    if invoice.nil? || reverse_total_days(invoice.issued) > 20

      puts "\n \n Invoice is not found \n \n "

      if store.premium.blank? || store.premium
        amount = Plan.where(name: 'premium').first.amount
        desc = 'premium'
      else
        amount = Plan.where(name: 'basic').amount
        desc = 'basic'
      end

      uid = "INV#{[*'A'..'Z', *"0".."9"].sample(8).join}"


      sub = Subscription.create(store_id: store.id, amount: amount, ref: uid, order_status_id: 5, description: desc)

      if store.premiumexpiry.nil?
        puts "\n \n \n STORE PREMIUM IS #{store.premium} and expiry is #{store.premiumexpiry} \n \n \n"
        from = Time.now - 1.month
        to = Time.now
      else
        puts "\n \n \n STORE PREMIUM IS #{store.premium} and expiry is #{store.premiumexpiry} \n \n \n"
        from = store.premiumexpiry - 1.month
        to = store.premiumexpiry
      end

      if sub
        new_inv = Invoice.create(from: from, to: to,
                                 uid: uid, store_id: store.id, amount: amount, issued: Time.now, due: Time.now + 7.days,
                                 tax: (ENV['tax'].to_i * amount), subtotal: (amount - (ENV['tax'].to_i * amount)), currency: 'KSH', subscription_id: sub.id, order_status_id: 5, invoice: "#{uid}_#{store.name}")

        if new_inv

          #puts " \n \n invoice id is #{new_inv.id} and issued is #{new_inv.issued} and invoice id is #{new_inv.uid}"


          FileUtils.mkdir_p "public/invoices/#{store.id}/"


          @store = store

          pdf = WickedPdf.new.pdf_from_string(
              ApplicationController.new.render_to_string(
                  :template => "invoices/invoice.html",
                  :layout => 'pdf.html',
                  :locals => {:@store => @store, :@invoice => new_inv}
              )
          )

          if Rails.env.development?
            save_path = Rails.root.join("public/invoices/#{store.id}/", "#{uid}_#{store.name}.pdf")
            File.open(save_path, 'wb') do |file|
              file << pdf
            end
          else
            save_path = Rails.root.join("public/invoices/#{store.id}/", "#{uid}_#{store.name}.pdf")
            File.open(save_path, 'wb') do |file|
              file << pdf
            end
            if upload(new_inv, store)
              File.delete(save_path) if File.exist?(save_path)
              puts 'invoice uploaded'
            end
          end

          InvoiceMailer::send_first_invoice(store, new_inv).deliver
          SmsController::week_notice(new_inv,store.phone)
        end
      end

    else
      puts "\n \n Invoice found\n \n "
      diff = DateTime.now - invoice.issued

      puts DateTime.now
      puts invoice.issued

      puts "Days since invoice was issued #{diff}"

      if diff > 20
        InvoiceMailer::send_first_invoice(store, invoice).deliver
        SmsController::week_notice(invoice,store.phone)
      end
    end
  end

  def self.send_final_invoice(store)

    puts ' \n sending final invoice'

    invoice = Invoice.where(store_id: store.id).last

    InvoiceMailer::send_reminder(store, invoice).deliver
    SmsController::final_sms(invoice,store.phone)

    puts ' \n sent!'

  end

  def self.disconnect(store)

    disconnect = store.update(premium: false, active: false, activatable: false, plan_id: nil, trial: false, p_explore: store.explore, explore: false)

    if disconnect
      puts "\n \n disconnect successfull"
      invoice = Invoice.where(store_id: store.id).last

      if invoice.nil?
        puts " \n \n existing invoice not found, generating a new one."

        if store.plan_id.nil? || store.premium
          amount = Plan.where(name: 'premium').first.amount
          desc = 'premium'
        else
          amount = Plan.where(name: 'basic').amount
          desc = 'basic'
        end

        uid = "INV#{[*'A'..'Z', *"0".."9"].sample(8).join}"

        sub = Subscription.create(store_id: store.id, amount: amount, ref: uid, order_status_id: 5, description: desc)

        if sub
          new_inv = Invoice.create(from: Time.now - 1.month, to: Time.now,
                                   uid: uid, store_id: store.id, amount: amount, issued: Time.now, due: Time.now + 7.days,
                                   tax: (ENV['tax'].to_i * amount), subtotal: (amount - (ENV['tax'].to_i * amount)), currency: 'KSH', subscription_id: sub.id, order_status_id: 5, invoice: "invoice_#{uid}_#{store.name}")

          if new_inv


            FileUtils.mkdir_p "public/invoices/#{store.id}/"


            @store = store

            pdf = WickedPdf.new.pdf_from_string(
                ApplicationController.new.render_to_string(
                    :template => "invoices/invoice.html",
                    :layout => 'pdf.html',
                    :locals => {:@store => @store, :@invoice => new_inv}
                )
            )

            if Rails.env.development?
              save_path = Rails.root.join("public/invoices/#{store.id}/", "#{uid}_#{store.name}.pdf")
              File.open(save_path, 'wb') do |file|
                file << pdf
              end
            else
              save_path = Rails.root.join("public/invoices/#{store.id}/", "#{uid}_#{store.name}.pdf")
              File.open(save_path, 'wb') do |file|
                file << pdf
              end
              if upload(new_inv, store)
                File.delete(save_path) if File.exist?(save_path)
              end
            end

            InvoiceMailer::disconnect(store, new_inv).deliver
            SmsController::suspend(new_inv,store.phone)
            new_inv.update(deliveries: true)
          end
        end

      else
        puts " \n \n existing invoice was found, sending invoice ...."
        done = invoice.deliveries
        if !done
          puts "Deliveries not done, sending final invoice"
          InvoiceMailer::disconnect(store, invoice).deliver
          SmsController::suspend(invoice,store.phone)
          invoice.update(deliveries: true)
        end
      end
    end
  end

  def self.reconnect_premium(s)
    s.update(premium: true, active: s.p_active, layout_id: s.p_layout_id, activatable: true, explore: s.p_explore)
  end

  def self.reconnect(s)
    s.update(premium: false, active: s.p_active, activatable: true, explore: s.p_explore)
  end

  def self.invoice
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@store.name}_Invoice",
               template: "invoices/invoice.html.erb",
               layout: 'pdf.html'
      end
    end
  end

  def self.upload(invoice, s)

    puts "Starting Upload"
    # Make an object in your bucket for your upload
    obj = S3_BUCKET.objects["invoices/#{s.id}/#{invoice.uid}_#{s.name}.pdf"]

    # Upload the file
    obj.write(
        file: "public/invoices/#{s.id}/#{invoice.uid}_#{s.name}.pdf",
        acl: :public_read
    )

    # Create an object for the upload
    @upload = invoice.update(
        url: obj.public_url,
        name: obj.key
    )

    # Save the upload
    if @upload
      true
    else
      false
    end
  end

end
