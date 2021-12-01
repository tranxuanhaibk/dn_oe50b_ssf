class PagesController < ApplicationController
  def search
    if params[:search].blank?
      flash[:danger] = t "search.danger"
      redirect_to root_path
    else
      @soccer_field = SoccerField.search_name(params[:search].downcase)
      return if @soccer_field.any?

      flash[:info] = t "search.info"
      redirect_to root_url
    end
  end
end
