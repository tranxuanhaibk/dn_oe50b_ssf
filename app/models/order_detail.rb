class OrderDetail < ApplicationRecord
  belongs_to :soccer_field
  has_many :orders, dependent: :destroy
  after_create :set_order_total_cost
  before_save :set_current_price
  validates_datetime :time_started
  validates_datetime :time_finished
  validates :booking_used, numericality: {only_integer: true,
                                          greater_than_or_equal_to: 0},
                           allow_blank: true
  scope :all_time, ->(param){where("soccer_field_id IN (?)", param).distinct}
  scope :time_yard, (lambda do |soccer_field_ids, time|
    where("soccer_field_id IN (?) AND time = ?", soccer_field_ids, time)
  end)

  def set_current_price
    self.current_price = soccer_field.price
  end
end
