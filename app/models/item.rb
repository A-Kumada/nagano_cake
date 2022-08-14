class Item < ApplicationRecord
 has_one_attached :image

 belongs_to :genre
 has_many :cart_items
 has_many :order_details

validates :is_active, inclusion: { in: [true, false] }

def with_tax_price
    (price * 1.1).floor
end

def get_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/IMG_8779_s-1024x1024.jpeg')
    image.attach(io: File.open(file_path), filename: 'IMG_8779_s-1024x1024.jpeg', content_type: 'image/jpeg')
  end
    self.image.variant(resize_to_limit: [width, height]).processed
end

end
