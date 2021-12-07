module OrdersHelper
  def handle_name_status name
    case name
    when Settings.admin_order.enum_status.pending
      t "booking.status.pending"
    when Settings.admin_order.enum_status.accept
      t "booking.status.accept"
    when Settings.admin_order.enum_status.rejected
      t "booking.status.rejected"
    else
      t "booking.status.cancel"
    end
  end

  def handle_layout name
    case name
    when Settings.admin_order.enum_status.pending
      "danger"
    when Settings.admin_order.enum_status.accept
      "success"
    when Settings.admin_order.enum_status.rejected
      "warning"
    else
      "active"
    end
  end

  def render_booking_button order, is_order_pending
    if is_order_pending
      text = t("booking.btn_handle")
      class1 = "btn btn-danger"
    else
      text = t("booking.btn_view")
      class1 = "btn btn-primary"
    end
    button_tag text, type: "button", class: class1,
              data: {toggle: "modal", target: "#model#{order.id}"}
  end
end
