class OrderDetail < ApplicationRecord
  belongs_to :soccer_field
  belongs_to :order

  delegate :field_name, :status,
           :description, to: :soccer_field, prefix: true

  enum type_field: {five: 0, seven: 1, elevent: 2}
  scope :all_time, ->(param){where("soccer_field_id IN (?)", param).distinct}
  scope :find_orders, ->(order_id){where("order_id = ?", order_id)}
  scope :find_sum_order, ->{group(:order_id).sum(:current_price)}
end
