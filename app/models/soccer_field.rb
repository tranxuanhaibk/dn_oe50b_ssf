class SoccerField < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :soccer_rates, dependent: :destroy
  scope :order_by_field_name, ->{order :field_name}
  validates :field_name, length:
                         {maximum: Settings.model.profile.name_length_max_50},
                         allow_blank: true
  validates :description, length:
                      {maximum: Settings.model.profile.length_max_255},
                      allow_blank: true
  enum status: {left: 0, over: 1}
  enum type_field: {five: 0, seven: 1, elevent: 2}

  validates :price, numericality: {only_integer: true,
                                   greater_than_or_equal_to: 0},
                    allow_blank: true

  scope :search_name, (lambda do |pr|
    where("lower(field_name) LIKE :search", search: "%#{pr}%") if pr.present?
  end)
end
