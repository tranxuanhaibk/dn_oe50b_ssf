class Admin::StatisticsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: false

  def index; end

  def month
    render json: Order.accept.group_by_month(:created_at).count
  end

  def week
    render json: Order.accept.group_by_week(:created_at).count
  end

  def year
    render json: Order.accept.group_by_year(:created_at).count
  end
end
