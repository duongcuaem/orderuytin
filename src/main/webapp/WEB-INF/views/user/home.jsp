<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="s" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
        <jsp:include page="/WEB-INF/views/commonUsers/head.jsp"></jsp:include>
    <link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">
</head>
<body style="background-color: black">

<!-- ! Body -->

<div class="page-flex">
    <!-- ! Sidebar -->
        <jsp:include page="/WEB-INF/views/commonUsers/sidebar.jsp"></jsp:include>
    <div class="main-wrapper">
        <!-- ! Main nav -->
            <jsp:include page="/WEB-INF/views/commonUsers/mainnav.jsp"></jsp:include>
            <jsp:include page="/WEB-INF/views/commonUsers/main.jsp"></jsp:include>
            <jsp:include page="/WEB-INF/views/commonUsers/footer.jsp"></jsp:include>

</div>
</div>
<!-- Chart library -->
<script src="/plugins/chart.min.js"></script>
<!-- Icons library -->
<script src="/plugins/feather.min.js"></script>
<!-- Custom scripts -->
<script src="/js/script.js"></script>
<script>
    $(document).ready(function() {
        // Lấy token từ localStorage
        var token = localStorage.getItem('token');
        if (!token) {
            $('#userInfo').text('Không tìm thấy token, vui lòng đăng nhập lại.');
            window.location.href = '/DoLogin';
        }

        $.ajax({
            type: 'GET',
            url: '/userInfo', // Endpoint để lấy thông tin người dùng
            headers: {
                'Authorization': 'Token ' + token
            },
            success: function(response) {
                if (response.error) {
                    $('#userInfo').text('Lỗi: ' + response.error);
                } else {
                    // Xử lý dữ liệu và hiển thị thông tin người dùng
                    $('#userName').text(response.loginUser.userName);
                    $('#rate').text('Tỉ giá : ' + response.loginUser.rate + ' đ/¥');
                    $('#rateKg').text('Tỉ giá kg : ' + response.loginUser.rateKg);
                    $('#rateM3').text('Tỉ giá m3 : ' + response.loginUser.rateM3);
                    $('#sumTotalVNUser').text(response.sumTotalVNUser);
                    $('#sumTotalCancelVNUser').text(response.sumTotalCancelVNUser);
                    $('#sumTotalFreightUser').text(response.sumTotalFreightUser);
                    $('#sumAmountUser').text(response.sumAmountUser);
                    $('#sumReFundVNUser').text(response.sumReFundVNUser);
                    $('#loginUser').text(response.loginUser);
                    $('#countCartItem').text(response.countCartItem);
                    $('#countPendingOrder').text(response.countPendingOrder);
                    $('#countBoughtOrder').text(response.countBoughtOrder);
                    $('#countDeliveredOrder').text(response.countDeliveredOrder);
                    $('#countArriveredOrder').text(response.countArriveredOrder);
                    $('#countFinishedOrder').text(response.countFinishedOrder);
                    $('#countCancelOrder').text(response.countCancelOrder);
                    $('#countComplainOrder').text(response.countComplainOrder);
                    $('#countWholeOrder').text(response.countWholeOrder);
                    $('#countCancelItem').text(response.countCancelItem);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                $('#userInfo').text('Không thể lấy thông tin người dùng, vui lòng thử lại sau.');
            }
        });
    });
</script>
</body>

</html>