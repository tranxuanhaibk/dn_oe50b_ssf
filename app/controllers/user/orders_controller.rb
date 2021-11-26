class User::OrdersController < ApplicationController
  before_action :logged_in_user, only: %i(index)

  def create
    order_param = Hash.new
    order_param[:order_detail_id] = params[:id_order_detail]
    order_param[:order_date] = params[:date]
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
