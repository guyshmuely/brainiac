class Course < ActiveRecord::Base

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  def price
    self.price_in_cents.to_f/100
  end

  def price=(dollars)
    self.price_in_cents=dollars.to_f*100
  end

  def price_in_cents
    super || 0
  end

end
