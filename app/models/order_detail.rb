class OrderDetail < ApplicationRecord
  belongs_to :soccer_field
  belongs_to :order

  enum type_field: {five: 0, seven: 1, elevent: 2}

  scope :all_time, ->(param){where("soccer_field_id IN (?)", param).distinct}
  scope :booking_used_soccer_field, (lambda do |soccer_field_ids, booking_used|
    where("soccer_field_id IN (?) AND booking_used = ?", soccer_field_ids, booking_used)
  end)
end
