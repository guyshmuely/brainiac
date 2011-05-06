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

end
