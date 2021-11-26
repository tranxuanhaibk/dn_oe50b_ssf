class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  validates :quantity, presence: true, allow_blank: true
  enum status: {pending: 0, accept: 1, rejected: 2, cancel: 3}
  enum is_payment: {pending: 0, approve: 1, cancled: 2}
end
