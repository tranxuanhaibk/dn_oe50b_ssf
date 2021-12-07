class User::OrderDetailsController < ApplicationController
  before_action :logged_in_user
  before_action :find_order_detail, only: :destroy

  def destroy
    ActiveRecord::Base.transaction do
      if @order_detail&.destroy
        @order_id = OrderDetail.find_orders(@order_detail.order_id)
        quantity =  @order_id.count
        update_order quantity
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".fail"
      end
    end
    respond_to do |format|
      format.html{render user_orders_path}
      format.json{render json: flash.to_hash}
    end
  end

  private

  def update_order quantity
    if quantity.zero?
      @order.destroy
    else
      sum_cost = OrderDetail.where(order_id: @order.id).find_sum_order
      total_cost = sum_cost.values[0]
      @order.update_order_new quantity, total_cost
    end
  end

  def find_order_detail
    @order_detail = OrderDetail.find_by id: params[:id]
    @order =  @order_detail.order
    return if @order_detail

    flash[:warning] = t "message.update_order.not_exist_id"
    redirect_to user_orders_path
  end
end
