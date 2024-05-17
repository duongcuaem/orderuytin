//progressloading
$(document).ajaxStart(function() {
   NProgress.start();
});
$(document).ajaxStop(function() {
   NProgress.done();
});

//loading che màn hình
function mLoading() {
    var tail = "<div style='background: rgba(1, 1, 1, .2); position: fixed; top: 0; left: 0; right: 0; bottom: 0; z-index: 9999;' id='my_loading' class='my_loading'><a style=' position: absolute; top: 45%; left: 46%; z-index: 99999; color: #fff;'>Đang tải</a></div>";
    $('body').append(tail);
}
function rmLoading() {
    $('.my_loading').remove();
}

function setCookie(cname, cvalue, exdays) {
  var d = new Date();
  d.setTime(d.getTime() + (exdays*24*60*60*1000));
  var expires = "expires="+d.toUTCString();
  document.cookie = cname + "=" + cvalue + "; " + expires + "; path=/";
}

function getCookie(cname) {
  var name = cname + "=";
  var ca = document.cookie.split(';');
  for(var i=0; i<ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0)==' ') c = c.substring(1);
      if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
  }
  return "";
}

function checkCookie(cookieName) {
    var check = getCookie(cookieName);

    if(check != 1) {
      $('#myModalAlert').modal('show');
    }
}

function checkCookieFreeOrder(cookieName) {
    var check = getCookie(cookieName);

    if(check != 1) {
      $('#btnBlogDissmissFreeOrder').modal('show');
    }
}

function markCookie(cookieName) {
    setCookie(cookieName, 1, 365);
}

/*==================== all action confirm ====================*/
$('.btn-confirm-action').click(function(e){
   e.preventDefault();
   var _url = $(this).attr('href');
   var _type = $(this).data('type') || '';
   var _relation = $(this).data('relation') || '';
   var deleteBtn = $(this);
   swal({
      title: "Bạn có chắc chắn thực hiện?",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Ok",
      cancelButtonText: "Cancel",
      showLoaderOnConfirm: true,
      closeOnConfirm: false
   },
   function(){
      $.ajax({
         url : _url,
         type: "GET",
         beforeSend: function(){
            deleteBtn.addClass('disabled');
         },
         success: function(data)
         {
            if (data.status == 'success') {
               if (_type == 'delete') {
                  deleteBtn.parents('tr').hide('fast');
                  if (_relation != "") $(_relation).hide('fast');
               }
               var msg = data.msg || "Thực hiện thành công.";
               swal({
                  type: "success",
                  title: "Action!",
                  text: msg,
                  timer: 2000,
                  showConfirmButton: false
               });
            } else if (data.status == 'error') {
               deleteBtn.removeClass('disabled');
               var msg = data.msg || "Thực hiện thất bại.";
               swal({
                  type: "error",
                  title: "Action!",
                  text: msg,
                  timer: 2000,
                  showConfirmButton: false
               });
            }
         }
      });
   });
});

function showNotify(stringAlert){
   $.gritter.add({
      // (string | mandatory) the heading of the notification
      title: 'Thông báo',
      // (string | mandatory) the text inside the notification
      text: stringAlert,
      time: 2000,
   });
}

function myLoading (){
   var tail = "<a id='my_loading' style='position: fixed; top: 40px; left: 46%; z-index: 99999;' class='btn btn-danger'><i class='fa fa-refresh fa-spin fa-1x'></i>  Đang tải...</a>";
   $('body').append(tail);
}

function redirectToURL(href) {
   window.location.href = href;
}

function confirmThis(obj, e) {
   e.preventDefault();
   bootbox.confirm('Bạn có chắc chắn không?', function(result) {
      if (result === true) {
         myUtility.redirectToURL(obj.attr('href'));
      }
   });
}

function takeValue(originClass, classValue){
  return originClass.siblings(classValue).children('input').val();
}
