class Admin::OrdersController < ApplicationController
  before_action :load_order, only: :update
  
  def index
    @orders = Order.status_asc.paginate page: params[:page],
      per_page: Settings.admin_order.per_page
  end
  
  def update
    respond_to do |format|
      if @order.update_status params[:stt]
        format.json{render json: @order, status: :created}
      else
        format.json{render status: :unprocessable_entity}
      end
    end
  end
  
  private
  
  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
  
    flash[:warning] = t "khong the load trang order "
    redirect_to admin_order_path
  end
end