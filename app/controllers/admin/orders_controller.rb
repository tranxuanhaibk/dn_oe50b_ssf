class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.status_asc.paginate page: params[:page],
      per_page: Settings.admin_order.per_page
  end
end
