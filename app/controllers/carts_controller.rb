class CartsController < ApplicationController
  def index
    if cookies[:soccer_fields].blank?
      flash[:warning] = t ".cart_empty"
      redirect_to root_path
    else
      @soccer_fields_cookies = JSON.parse(cookies[:soccer_fields])
      @soccer_fields_db = SoccerField.where(id: @soccer_fields_cookies.keys)
    end
  end

  def create
    detail = OrderDetail.find_by(soccer_field_id: params[:soccer_field_id],
      booking_used: params[:time], type_field: params[:type],
      order_date: params[:date])
    if detail.present? && !detail.order.cancel?
      render json: {error: true}
    else
      size_cart = add_product params
      render json: {size_cart: size_cart}
    end
  end
end
