namespace :invoice do
  desc "TODO"
  task generate: :environment do
    puts "Updating stuff"
    Invoice.connection
    puts "Working"
    Invoice::generate
    puts "#{Time.now} — Success!"
  end

end
