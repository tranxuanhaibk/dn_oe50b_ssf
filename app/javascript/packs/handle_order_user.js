$(document).ready(function() {
  $('.handle-order-user').click(function() {
    $.ajax({
      type: 'PATCH',
      url: "/user/orders/"+$(this).data().id,
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: {
        id: $(this).data().id,
        stt: $(this).data().stt
      },
      dataType: 'JSON'
    }).done(function (data) {
      alert(data.notice);
      location.reload();
    }).fail(function (data) {
      alert(data.alert);
    });
  });
  $('.handle-delete-order-detail').click(function() {
    $.ajax({
      type: 'DELETE',
      url: "/user/order_details/"+$(this).data().id,
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: {
        id: $(this).data().id,
      },
      dataType: 'JSON'
    }).done(function (data) {
      alert(data.success);
      location.reload();
    }).fail(function (data) {
      alert(data.danger);
    });
  });
})
