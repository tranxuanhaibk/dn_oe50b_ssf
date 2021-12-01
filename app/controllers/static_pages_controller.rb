class StaticPagesController < ApplicationController
  def home
    @soccer_fields = SoccerField.order_by_field_name
                                .paginate(page: params[:page],
                                          per_page: Settings.paginate.home)
  end

  def detail; end
end
