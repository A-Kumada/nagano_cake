class Address < ApplicationRecord

  belongs_to :customer

  def view_address
    "〒"+postal_code+" "+address+" "+name
  end

end
