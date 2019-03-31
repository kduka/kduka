class InvoicesController < ApplicationController
  def generate
    require 'active_support'
    store = Store.all

    store.each do |s|
      # Check if store is currently on a plan

      if !s.premium?
        #If on premium, Is the subscription ending in the next 7 days?
        if total_days(s.premiumexpiry) < 7
          send_invoice(s)
        end

        #Generate Invoice for the same plan and send

      else
        #If not on Premium, Is there an existing invoice?
        # Retrieve invoices with store_id and unpaid
        invoice = Invoice.where(store_id: s.id, order_status_id: 5).first
        if !invoice.nil?

          #If an invoice exists ... TUTAJUA
        else
          #If it doesn't exist. Generate one for premium plan and send
          #
          respond_to do |format|
            format.html
            format.pdf do
              render pdf: "#{s.name}_Invoice",
                     template: "admins/invoice.html.erb",
                     layout: 'pdf.html',
                     save_to_file: Rails.root.join('public', "#{s.name}_Invoice"),
                     save_only: true
            end
          end
        end
      end
    end
    end



  def check_trials

  end

  def total_days(expiry)
    difference_in_days = (expiry - Date.today).to_i
    puts difference_in_days
    difference_in_days
  end

  def send_invoice(store)
    put "INVOICEYYY"
  end

end
