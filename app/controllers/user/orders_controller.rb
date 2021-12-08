class User::OrdersController < ApplicationController
  def index
    @orders = current_user.orders.date_desc.paginate page: params[:page],
    per_page: Settings.admin_order.per_page
  end

  def order_soccer_field
    JSON.parse(cookies[:soccer_fields]).each do |key, value|
      soccer_field = SoccerField.find key
      ActiveRecord::Base.transaction do
        ordered = Order.create(user_id: current_user.id, quantity: value.length,
                      status: 0, total_cost: soccer_field.price * value.length)
        create_order_detail value, ordered, soccer_field
      end
    end
    delete_cookie_soccer_field
  end

  private

  def create_order_detail value, ordered, soccer_field
    value.each do |i|
      value_detail = i.split(",")
      time = value_detail[0]
      date = value_detail[1]
      type = value_detail[2]
      soccer_field.order_details.create(order_id: ordered.id,
                current_price: soccer_field.price,
                booking_used: time, type_field: type, order_date: date)
    end
  end

  def delete_cookie_soccer_field
    cookies.delete :soccer_fields
    flash[:success] = t "order.success"
    redirect_to root_path
  end
end
