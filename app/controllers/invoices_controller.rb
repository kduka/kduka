class InvoicesController < ApplicationController
  def generate
    require 'active_support'
    stores = Store.all

    stores.each do |s|
      if s.premium?

        puts "Total days diff is #{total_days(s.premiumexpiry)}"

        if total_days(s.premiumexpiry) < 1
          disconnect(s)
        elsif total_days(s.premiumexpiry) == 1
          send_final_invoice(s)
        elsif total_days(s.premiumexpiry) < 7
          generate_invoice(s)
        end

      else

        if total_days(s.premiumexpiry) < 1
          disconnect(s)
        elsif total_days(s.premiumexpiry) == 1
          send_final_invoice(s)
        elsif total_days(s.premiumexpiry) < 7
          generate_invoice(s)
        end

      end
    end
  end


  def check_trials
    require 'active_support'
    s = Store.where(trial: true).first


    puts "Total days diff is #{total_days(s.trial_end)}"


    if total_days(s.trial_end) < 7
      send_invoice(s)
    end

  end

  def total_days(expiry)
    difference_in_days = (expiry - Date.today).to_i
  end


  def reverse_total_days(issue_day)
    difference_in_days = (Date.today - issue_day).to_i
  end

  def generate_invoice(store)

    invoice = Invoice.where(store_id: store.id).last


    if invoice.nil?

      if store.premium.blank? || store.premium
        amount = Plan.where(name: 'premium').first.amount
      else
        amount = Plan.where(name: 'basic').amount
      end

      iid = "INV#{[*'A'..'Z', *"0".."9"].sample(8).join}"

      sub = Subscription.create(store_id: store.id, amount: amount, ref: iid, order_status_id: 2, description: 'month')

      if sub
        new_inv = Invoice.create(from: Date.today.at_beginning_of_month.last_month, to: Date.today.at_end_of_month.last_month,
                                 uid: iid, store_id: store.id, amount: amount, issued: Time.now, due: Time.now + 7.days,
                                 tax: (ENV['tax'].to_i * amount), subtotal: (amount - (ENV['tax'].to_i * amount)), currency: 'KSH', subscription_id: sub.id, order_status_id: 5, invoice: "invoice_#{iid}_#{Time.now.strftime('%Y%m%d')}")

        if new_inv

          if Rails.env.development?
            FileUtils.mkdir_p "public/invoices/#{store.id}/"
          else

          end

          @store = store

          pdf = WickedPdf.new.pdf_from_string(
              render_to_string("invoices/invoice.html", layout: 'pdf.html'),
          )

          save_path = Rails.root.join("public/invoices/#{store.id}/", "#{iid}_#{Time.now.strftime('%Y%m%d')}.pdf")
          File.open(save_path, 'wb') do |file|
            file << pdf
          end

          InvoiceMailer::send_first_invoice(store, iid).deliver
        end
      end

    else
      InvoiceMailer::send_first_invoice(store, invoice.uid).deliver
    end
  end

  def create_pdf(s)
    puts " \n \n \n GENERATING INVOICE FOR #{store.name} \n \n \n "

    pdf = WickedPdf.new.pdf_from_string(
        render_to_string("invoices/invoice.html", layout: 'pdf.html'),
    )

    save_path = Rails.root.join('public', "#{store.name}.pdf")
    File.open(save_path, 'wb') do |file|
      file << pdf
    end
  end

  def send_final_invoice(store)

    puts " \n \n \n SENDING INVOICE TO #{store.name} \n \n \n "

    pdf = WickedPdf.new.pdf_from_string(
        render_to_string('admins/invoice.html', layout: 'pdf.html'),
    )

    save_path = Rails.root.join('public', "#{store.name}.pdf")
    File.open(save_path, 'wb') do |file|
      file << pdf
    end

  end

  def disconnect(s)

    disconnect = s.update(premium: false, p_active: s.active, active: false, p_layout_id: s.layout_id, layout_id: 1, activatable: false)
    if disconnect
      #Send Email Notification
      InvoiceMailer::send_first_invoice(s).deliver
    end
  end

  def reconnect_premium(s)
    s.update(premium: true, active: s.p_active, layout_id: s.p_layout_id, activatable: true)
  end

  def reconnect(s)
    s.update(premium: false, active: s.p_active)
  end

  def invoice
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@store.name}_Invoice",
               template: "invoices/invoice.html.erb",
               layout: 'pdf.html'
      end
    end
  end

end
