class User::OrdersController < ApplicationController
  before_action :logged_in_user, only: %i(index seach_soccer_field_for_order)

  def seach_soccer_field_for_order
    soccer_field = SoccerField.find_by(id: params[:soccer_field_id], type_field: params[:soccer_field_id])
    @order_details = current_user.order_detail.where(soccer_field_id: soccer_field.id)
    @ordered_list = Order.find_date_order(@soccer_fields.pluck(:id),
                                     params[:date]).pluck(:order_detail_id)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def order_soccer_field
    JSON.parse(cookies[:soccer_fields]).each do |key, value|
      soccer_field = SoccerField.find key

      ordered = Order.create(user_id: current_user.id, quantity: value.length,
                            status: 1, total_cost: soccer_field.price * value.length)

      value.each do |i|
        value_detail = i.split(',')
        time = value_detail[0]
        date = value_detail[1]
        type = value_detail[2]
        soccer_field.order_details.create(order_id: ordered.id, current_price: soccer_field.price,
                                          booking_used: time, type_field: type, order_date: date)
      end
    end
    cookies.delete :soccer_fields

    flash[:success] = "Dat san thanh cong"
    redirect_to root_path
  end

  def create
    @order = current_user.orders.build order_param
    @data = Hash.new
    respond_to do |format|
      handle_message @order.save, @data
      format.json{render json: @data.to_json, status: :created}
    end
  end

  def index
    @orders = current_user.orders.date_desc.paginate page: params[:page],
      per_page: Settings.admin_order.per_page
  end

  private

  def logged_in_user
    return if logged_in?

    strore_location_system static_page_path(params[:soccer_field_id])
    respond_to do |format|
      format.js do
        render js:
        "Swal.fire('#{"message_booking_pls_login"}')
        .then((value) => {
          window_soccer_field='#{login_path}'
        })"
      end
    end
  end

  def handle_message condition, data
    if condition
      data[:success] = true
      data[:title] = "message_booking_booking_succ"
      data[:content] = t "message_booking_booking_succ_mess"
    else
      data[:title] = "message_booking_booking_fail"
      data[:content] = "message_booking_booking_fail_mess"
    end
  end
end
