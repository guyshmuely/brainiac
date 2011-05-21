class Course < ActiveRecord::Base
  has_and_belongs_to_many :accounts
  belongs_to :account
  has_many :cards
  has_attached_file :image,
                    :storage => :s3,
                    :path => "/:attachment/:id/:style/:filename",
                    :s3_credentials => {:access_key_id => S3[:key],
                                        :secret_access_key => S3[:secret]},
                    :bucket => S3[:bucket],
                    :styles => { :medium => "300x300>", :thumb => "100x100>" }

  has_attached_file :icon,
                    :storage => :s3,
                    :path => "/:attachment/:id/:style/:filename",
                    :s3_credentials => {:access_key_id => S3[:key],
                                        :secret_access_key => S3[:secret]},
                    :bucket => S3[:bucket],
                    :styles => { :medium => "300x300>", :thumb => "57x57>" }

  def price
    self.price_in_cents.to_f/100
  end

  def price=(dollars)
    self.price_in_cents=dollars.to_f*100
  end

  def price_in_cents
    super || 0
  end

  def number_of_cards
    self.cards.count
  end

  validates_presence_of(:title)
  validates_presence_of(:display_name)
  validates_presence_of(:price_in_cents)

  def export_cards_to_excel
    columns=[:question,:solution]
    column_titles=['שאלה','תשובה']
    data = StringIO.new('')
    format = Spreadsheet::Format.new :text_direction=>:rtl, :horizontal_align=>:right
    Spreadsheet.client_encoding = 'UTF-8'
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    sheet.default_format = format
    sheet.name = "#{self.title} - כרטיסיות"
    cards = self.cards
    if cards.any?
      sheet.row(0).concat column_titles.collect(&:to_s)
      cards.each_with_index do |item,i|
        row = sheet.row(i+1)
        columns.each do |column|
          if item.nil?
            row.push(nil)
          elsif column.is_a?(String) or column.is_a?(Symbol)
            puts column.inspect
            puts item.send(column).inspect
            row.push(item.send(column).to_s)
          end
        end
      end
    end
    book.write(data)
    return data.string
  end

  def import_cards_from_excel(data)
    return 0 if data.nil?
    Spreadsheet.client_encoding = 'UTF-8'
    data = StringIO.new(data.read)
    book = Spreadsheet.open data
    sheet1 = book.worksheet 0
    attributes={}
    number_of_imported_cards=0
    imported_cards_ids = []
    sheet1.each_with_index do |row,i|
      puts "number: #{i}"
      puts "invitation: #{row[9]}"
      unless i==0
        attributes[:solution] = row[1]
        attributes[:question] = row[0]
        puts "saving invitation: #{attributes.inspect}"
        card = self.cards.create attributes
        imported_cards_ids << card.id
      end
      number_of_imported_cards = i
    end
    self.cards.each{|c| c.destroy unless imported_cards_ids.include?(c.id)}
    return number_of_imported_cards
  end

end
