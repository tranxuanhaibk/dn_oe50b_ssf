module CartsHelper
  def add_product params
    soccer_field_id = params[:soccer_field_id]
    date = params[:date]
    type = params[:type]
    time = params[:time]
    str = time + "," + date + "," + type
    check_cookie_cart
    if @soccer_fields.key? soccer_field_id
      return false if @soccer_fields[soccer_field_id].include? str

      @soccer_fields[soccer_field_id] = @soccer_fields[soccer_field_id] << str
    else
      @soccer_fields[soccer_field_id] = [str]
    end
    update_cookie_cart @soccer_fields
    @soccer_fields.values.flatten.size
  end

  def check_cookie_cart
    @soccer_fields = cookies[:soccer_fields]
    return @soccer_fields = Hash.new if @soccer_fields.blank?

    @soccer_fields = JSON.parse cookies[:soccer_fields]
  end

  def size_cart
    @soccer_fields = cookies[:soccer_fields]
    return 0 if @soccer_fields.blank?

    JSON.parse(cookies[:soccer_fields]).values.flatten.size
  end

  def update_cookie_cart soccer_fields
    cookies.permanent[:soccer_fields] = JSON.generate soccer_fields
  end
end
