class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy

  validates :quantity, presence: true, allow_blank: true
  enum status: {pending: 0, accept: 1, rejected: 2, cancel: 3}
  delegate :booking_used, :current_price, to: :order_details, prefix: true

  scope :status_asc, ->{order status: :asc}
  scope :date_desc, ->{order created_at: :desc}
  scope :find_date_order, (lambda do |order_detail_ids, date|
    where(
      "order_detail_id IN (?) AND order_date = ? AND status = ? OR status = ?",
      order_detail_ids, date, Order.statuses[:accept], Order.statuses[:pending]
    )
  end)

  def update_status status
    update_column(:status, status)
  end

  def update_order_new quantity, total_cost
    update_columns quantity: quantity, total_cost: total_cost
  end
end
