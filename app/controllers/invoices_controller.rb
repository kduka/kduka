class InvoicesController < ApplicationController
  def generate
    require 'active_support'
    s = Store.find(1)

    if s.premium?

      puts "Total days diff is #{total_days(s.premiumexpiry)}"

      if total_days(s.premiumexpiry) < 1
          disconnect(s)
      elsif total_days(s.premiumexpiry) == 1
        send_final_invoice(s)
      elsif total_days(s.premiumexpiry) < 7
        send_invoice(s)
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
    puts "EXPIRY IS #{expiry}"
    puts "DATE IS #{Date.today}"
    difference_in_days = (expiry - Date.today).to_i
    puts difference_in_days
    difference_in_days
  end

  def send_invoice(store)
    puts " \n \n \n SENDING INVOICE TO #{store.name} \n \n \n "

    pdf = WickedPdf.new.pdf_from_string(
        render_to_string('admins/invoice.html', layout: 'pdf.html'),
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

    disconnect = s.update(premium:false,p_active:s.active,active:false,p_layout_id:s.layout_id,layout_id:1, activatable:false)
    if disconnect

      #Send Email Notification
    end
  end

  def reconnect_premium(s)
    s.update(premium:true,active:s.p_active, layout_id:s.p_layout_id,activatable:true)
  end

  def reconnect(s)
    s.update(premium:false,active:s.p_active)
  end

end
