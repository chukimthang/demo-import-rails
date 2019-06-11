class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, uniqueness: true, length: {in: 3..50}

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    list_error = []
    if spreadsheet == "invalid"
      list_error << "File invalid"
      return list_error
    end
    header = spreadsheet.row(2)
    (3..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = Product.find_by_code(row["Code"])
      if product.nil?
        product = Product.new
        product.code = row["Code"]
        product.name =row["Name"]
        category = Category.find_by_name row["Category"]
        if category.blank?
          category = Category.create(name: row["Category"])
        end
        product.category_id = category.id
        unless product.save
          product.errors.full_messages.each do |msg|
            list_error << product.code + ": " + msg
          end
        end
      end
    end
    return list_error
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else "invalid"
    end
  end
end
