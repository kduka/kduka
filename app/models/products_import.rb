class ProductsImport
  include ActiveModel::Model
  require 'roo'

  attr_accessor :file

  def initialize(attributes={})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def load_imported_products
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(6)
    (7..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      row[:store_id] = $store
      puts " \n \n \n \n This is the Store ID : #{$store} \n \n \n \n"
      product = Product.where(id:row["id"],store_id: $store).first
       if product.present?
        product.attributes = row.to_hash
        product
       else
         row[:id] = nil
         row[:sku] = [*'A'..'Z', *"0".."9"].sample(8).join
         product= Product.new
         product.attributes = row.to_hash
         product
       end
    end
  end

  def imported_products
    @imported_products ||= load_imported_products
  end

  def save
    if imported_products.map(&:valid?).all?
      imported_products.each(&:save!)
      true
    else
      imported_products.each_with_index do |product, index|
        product.errors.full_messages.each do |msg|
          errors.add :base, "Row #{index + 7}: #{msg}"
        end
      end
      false
    end
  end

end
