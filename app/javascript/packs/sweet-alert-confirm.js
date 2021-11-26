function handle_order(date,id_timecost){
  var token = $('meta[name="csrf-token"]').attr('content')
  $.ajax({
    type: 'POST',
    url: '/user/orders',
    data: {
      date: date,
      id_order_detail: id_order_detail
    },
    headers: {
      "x-csrf-token": token,
    },
    dataType: 'JSON',
    success: function (response) {
      if(response.success)
          var icon = 'success'
      else
        var icon = 'error'
      Swal.fire(
        response.title,
        response.content,
        icon
      ).then((result) => {
        if (result.isConfirmed) {
          location.reload();
        }
      })
    }
  });
}

$(document).ready(function() {
  $(document).on('click','.ordered_soccer_field',function(){
    Swal.fire({
      icon: 'error',
      title: 'Hmmm...',
      text: 'Sân này đã được đặt!',
    })
  });
  $(document).on('click','.ordering_soccer_field',function(){
    var soccer_field_id = $(this).data('soccer_field_id')
    var field_name = $(this).data('field_name')
    var booking_used = $(this).data('booking_used')
    var type_field = $(this).data('type_field')
    var current_price = $(this).data('current_price').split(".")[0]
    var date = $('#date').val()
    var order_detail_id = $(this).data('id')
    Swal.fire({
      title: 'Xác nhận thông tin đặt sân',
      html:
        `<b>Tên sân: </b>${field_name}<br>
        <b>Ngày: </b>${date}<br>
        <b>Thời gian: </b>${booking_used}<br>
        <b>Loại sân: </b>${type_field}<br>
        <b>Mã sân: </b>${soccer_field_id}<br>
        <b>Giá tiền: </b>${current_price}<br>`,
      icon: 'info',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      cancelButtonText: 'Hủy',
      confirmButtonText: 'Đặt sân'
    }).then((result) => {
      if (result.isConfirmed) {
        handle_order(date,order_detail_id)
      }
    })
  });
})
