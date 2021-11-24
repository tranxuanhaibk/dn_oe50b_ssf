class Admin::SoccerFieldsController < ApplicationController
  def index
    @soccer_fields = SoccerField.order_by_field_name
                                .paginate(page: params[:page],
                                          per_page: Settings.paginate.manage)
  end

  def new
    @soccer_fields = SoccerField.new
  end

  def create
    @soccer_fields = SoccerField.new soccer_field_params
    if @soccer_fields.save
      flash[:success] = t "soccer_fields_controller.create_success"
      redirect_to admin_soccer_fields_path
    else
      flash.now[:warning] = t "soccer_fields_controller.create_warning"
      render :new
    end
  end

  private

  def soccer_field_params
    params.require(:soccer_field)
          .permit(:field_name, :type_field, :address, :price, :status)
  end
end
