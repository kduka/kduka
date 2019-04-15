class Invoice < ApplicationRecord
  belongs_to :store

  def self.generate
    require 'active_support'
    stores = Store.all

    stores.each do |s|

    puts "store activatable is #{s.activatable}"

    if s.activatable == false

      puts'skipping deactivated store'

    elsif s.plan_id == 2

      puts "Total days diff is #{total_days(s.premiumexpiry)}"

      if total_days(s.premiumexpiry) < 0
        disconnect(s)
      elsif total_days(s.premiumexpiry) == 1
        send_final_invoice(s)
      elsif total_days(s.premiumexpiry) <= 7
        generate_invoice(s)
      else
        puts "\n \n 1. KIRIMINO KABISA, GENERATE INVOICE #{s.name} \n \n "
        generate_invoice(s)
      end

    elsif s.trial

      puts "\n \n Trial Store \n \n "
      puts "Total days diff is #{total_days(s.trial_end)}"

      if total_days(s.trial_end) < 0
        puts "disconnecting trial store"
        disconnect(s)
      elsif total_days(s.trial_end) == 1
        puts "sending final invoice trial store"
        send_final_invoice(s)
      elsif total_days(s.trial_end) <= 7
        puts "generating invoice for trial store"
        generate_invoice(s)
      else
        puts "\n \n 1. KIRIMINO KABISA, GENERATE INVOICE #{s.name} \n \n "
        generate_invoice(s)
      end


    else
      puts "\n \n This is not premium \n \n "

      if total_days(s.premiumexpiry) < 0
        puts "\n \n DISCONNECTING #{s.name} \n \n "
        disconnect(s)
      elsif total_days(s.premiumexpiry) == 1
        puts "\n \n SENDING INVOICE FOR #{s.name} \n \n "
        send_final_invoice(s)
      elsif total_days(s.premiumexpiry) <= 7
        puts "\n \n GENERATING INVOICE FOR #{s.name} \n \n "
        generate_invoice(s)
      else
        puts "\n \n 2. KIRIMINO KABISA, GENERATE INVOICE #{s.name} \n \n "
        generate_invoice(s)
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

    puts "Is invoice nil? #{invoice.nil?}, reverse total days is #{reverse_total_days(invoice.issued) rescue nil}"

    if invoice.nil? || reverse_total_days(invoice.issued) > 20

      puts "\n \n Not Nil invoice \n \n "

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
                  :locals => {:@store => @store,:@invoice => new_inv}
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



          InvoiceMailer::send_first_invoice(store, new_inv).deliver
        end
      end

    else
      puts "\n \n Nil Invoice \n \n "
      diff = DateTime.now - invoice.issued

      puts DateTime.now
      puts invoice.issued

      puts "The Total days diff is #{diff}"

      if diff > 8
        InvoiceMailer::send_first_invoice(store, invoice).deliver
      end
    end
  end

  def self.send_final_invoice(store)

    invoice = Invoice.where(store_id: store.id).last

    InvoiceMailer::send_reminder(store, invoice).deliver

  end

  def self.disconnect(store)

    disconnect = store.update(premium: false, p_active: store.active, active: false, p_layout_id: store.layout_id, layout_id: 1, activatable: false, plan_id:nil, trial:false,p_explore:store.explore,explore:false)

    if disconnect
      puts "\n \n disconnect successfull"
      invoice = Invoice.where(store_id: store.id).last

      if invoice.nil?
        puts " \n \n existing invoice not found"

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
                    :locals => {:@store => @store,:@invoice => new_inv}
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
            new_inv.update(deliveries: true)
          end
        end

      else
        puts " \n \n existing invoice found"
        done = invoice.deliveries
        if !done
          InvoiceMailer::disconnect(store, invoice).deliver
          invoice.update(deliveries: true)
        end
      end
    end
  end

  def self.reconnect_premium(s)
    s.update(premium: true, active: s.p_active, layout_id: s.p_layout_id, activatable: true, explore:s.p_explore)
  end

  def self.reconnect(s)
    s.update(premium: false, active: s.p_active,activatable: true, explore:s.p_explore)
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
