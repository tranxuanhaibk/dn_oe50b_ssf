$(document).on('click','.handle-request-order',function(){
  $.ajax({
    type: 'PATCH',
    url: "/admin/orders/"+$(this).data().id,
    data: {
      id: $(this).data().id,
      stt: $(this).data().stt
    },
    dataType: 'JSON'
  }).done(function (data) {
    Swal.fire(
      'Xác nhận thành công',
      '',
      'success'
    ).then((result) => {
      if (result.isConfirmed) {
        soccer_field.reload();
      }
    })
  }).fail(function (data) {
    Swal.fire(
      'Xác nhận thất bại',
      '',
      'error'
    ).then((result) => {
      if (result.isConfirmed) {
        soccer_field.reload();
      }
    })
  });
});
