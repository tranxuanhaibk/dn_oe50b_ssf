module CartsHelper
  def add_product params
    soccer_field_id = params[:soccer_field_id]
    date = params[:date]
    type = params[:type]
    time = params[:time]
    @soccer_fields = cookies[:soccer_fields].blank? ? Hash.new : JSON.parse(cookies[:soccer_fields])
    str = time + "," + date + "," + type
    
    if @soccer_fields.key? soccer_field_id
      if @soccer_fields[soccer_field_id].include? str
        return false
      else
        @soccer_fields[soccer_field_id] = @soccer_fields[soccer_field_id] << str
      end
    else
      @soccer_fields[soccer_field_id] = [str]
    end
    
    update_cookie_cart @soccer_fields
    @soccer_fields.values.flatten.size
  end

  def size_cart
    cookies[:soccer_fields].blank? ? 0 : JSON.parse(cookies[:soccer_fields]).values.flatten.size
  end

  def update_cookie_cart soccer_fields
    cookies.permanent[:soccer_fields] = JSON.generate soccer_fields
  end
end
