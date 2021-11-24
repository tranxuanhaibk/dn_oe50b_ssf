class Admin::SoccerFieldsController < ApplicationController
  def index
    @soccer_fields = SoccerField.order_by_field_name
                                .paginate(page: params[:page],
                                          per_page: Settings.paginate.manage)
  end
end
