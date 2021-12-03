class StaticPagesController < ApplicationController
  before_action :load_soccer_field, only: :show
  def index
    @soccer_fields = SoccerField.order_by_field_name
                                .paginate(page: params[:page],
                                          per_page: Settings.paginate.home)
  end

  def show
    soccer_fields = SoccerField.pluck(:id)
    @booking_used = OrderDetail.all_time(soccer_fields).pluck(:booking_used)
  end

  private

  def load_soccer_field
    @soccer_field = SoccerField.find_by(id: params[:id])
    return if @soccer_field

    flash[:warning] = "message.update_booking.not_exist_id"
    redirect_to root_path
  end
end
