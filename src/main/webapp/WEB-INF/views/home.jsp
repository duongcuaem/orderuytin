<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tìm hàng trung quốc giá rẻ</title>
    <meta name="description" content="">
    <meta name="keywords" content="dat hang trung quoc, mua hang trung quoc, van chuyen hang">
    <meta charset="utf-8">
    <meta name="author" content="order">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

    <!-- Load Core CSS -->
    <link rel="stylesheet" href="/asset/gdqc/assets/css/core/bootstrap.min.css">
    <link rel="shortcut icon" href="/img/svg/logo.svg" type="image/x-icon">
    <script src="/asset/gdqc/assets/js/core/jquery.min.js"></script>
    <script src="/asset/gdqc/assets/js/core/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/7fef329ee5.js" crossorigin="anonymous"></script>
    <!-- Load SocketJS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

    <link rel="stylesheet" href="/asset/frontend/css/index_01.css">
    <link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">

    <style type="text/css">
        .bg-green {
            background: #5cb85c;
        }
        body {
            font-family: Arial;
            font-size: 16px;
        }
        .div-decorate a.cart-icon i {
            padding: 2px 3px 0 0;
        }
        
    </style>
</head>
<body class="darkmode">
    <!-- header section -->
    <%@include file="header.jsp" %>
    <div style="background-image: url('/orderuytin/banner.jpg');min-height: 100px; background-attachment: fixed; background-position: center; background-repeat: no-repeat; background-size: cover;">
        <div style="padding:10%;text-align:center;font-size:30px;font-weight:bold;background: rgba(0, 0, 0, 0.5);color: #f1f1f1;">
            <h1>CHUYÊN ĐẶT HÀNG TỪ TẤT CẢ CÁC NỀN TẢNG THƯƠNG MẠI ĐIỆN TỬ HÀNG ĐẦU TRUNG QUỐC</h1>
            <p>Tư vấn, tìm kiếm nguồn hàng và nhập hàng trực tuyến từ rất nhiều nguồn hàng đa dạng phong phú từ khắp Trung Quốc.</p>
            <p>Chúng tôi cam kết một dịch vụ vượt trội và cải tiến liên tục</p>
            <p>Bạn cần nhập hàng! Hãy đến với ORDERUYTIN.COM!</p>
        </div>
    </div>

    <div class="order-source">
        <div class="container">
            <div class="col-xs-12 col-sm-12 col-md-10 col-lg-10 col-md-offset-1 col-lg-offset-1">
                <div class="source-title">
                    <div class="head-text">Website đặt hàng</div>
                    <div class="content-text">
                        Orderuytin.com là đơn vị cung cấp dịch vụ trung gian nhập hàng từ các website thương mại điện tử hàng đầu Trung Quốc như: wholesaler.alibaba.com, 1688.com, taobao.com, tmall.com...
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <a href="https://1688.com/" target="_blank" class="no-decorate">
                    <div class="div-box">
                        <div class="thumbnail">
                            <img src="https://ordertietkiem.com//ordertietkiem/logo1688.png" alt="...">
                            <div class="caption">
                                <h3></h3>
                                <p>Giá cả cạnh tranh, đảm bảo rẻ nhất trên thị trường order ....</p>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <a href="https://tmall.com/" target="_blank" class="no-decorate">
                    <div class="div-box">
                        <div class="thumbnail">
                            <img src="https://ordertietkiem.com//ordertietkiem/logotmall.png" alt="...">
                            <div class="caption">
                                <p>Chất lượng và dịch vụ tốt nhất, đảm bảo uy tín cao....</p>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <a href="https://taobao.com/" target="_blank" class="no-decorate">
                    <div class="div-box">
                        <div class="thumbnail">
                            <img src="https://ordertietkiem.com//ordertietkiem/logotaobao.png" alt="...">
                            <div class="caption">
                                <p>Hàng về đều, liên tục...</p>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <div style="background-image: url('/orderuytin/banner1.jpg');min-height: 500px; background-attachment: fixed; background-position: center; background-repeat: no-repeat; background-size: cover;">
        <div style="padding:10%;text-align:center;font-size:50px;font-weight:bold;background: rgba(0, 0, 0, 0.5);color: #f1f1f1;">
            Orderuytin.com tự hào với đội ngũ nhân viên chuyên nghiệp, nhiệt tình, hỗ trợ đắc lực cho khách hàng, đáp ứng kì vọng trong một thị trường đầy biến động.
        </div>
    </div>

    <div class="content">
        <div class="container">
            <div class="head-text">Dịch vụ Orderuytin.com cung cấp</div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <div class="content-size">
                    <div class="img-service">
                        <img src="https://ordertietkiem.com//ordertietkiem/a1.jpg">
                    </div>
                    <div class="img-content">
                        <div class="head-img">
                            <b>Order hàng</b>
                        </div>
                        <div class="content-text">
                            Dịch vụ đặt hàng trực tiếp trên các trang taobao.com, 1688.com, tmall.com với phí dịch vụ rẻ nhất cho khách hàng ...
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <div class="content-size">
                    <div class="img-service">
                        <img src="https://ordertietkiem.com//ordertietkiem/a3.png">
                    </div>
                    <div class="img-content">
                        <div class="head-img">
                            <b>Tìm nguồn hàng</b>
                        </div>
                        <div class="content-text">
                            Dịch vụ tìm nguồn hàng, đàm phán, ký kết hợp đồng với Nhà Cung Cấp uy tín tại Trung Quốc ...
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <div class="content-size">
                    <div class="img-service">
                        <img src="https://ordertietkiem.com//ordertietkiem/a2.jpg">
                    </div>
                    <div class="img-content">
                        <div class="head-img">
                            <b>Ship hộ hàng</b>
                        </div>
                        <div class="content-text">
                            Dịch vụ chuyển hàng từ TQ về Việt Nam với giá thành thấp nhất, đảm bảo uy tín, thời gian, vận chuyển trên toàn quốc ...
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div style="background-image: url('/orderuytin/banner2.jpg');min-height: 500px; background-attachment: fixed; background-position: center; background-repeat: no-repeat; background-size: cover;">
        <div style="padding:10%;background: rgba(0, 0, 0, 0.5);color: #f1f1f1;">
            <div class="rate-img">
                <div class="container">
                    <div class="div-padding">
                        <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                            <div class="rate-out">
                                <i class="fa-solid fa-hourglass" style="font-size:60px"></i>
                                <div class="rate-detail">
                                    <span class="increment">9</span>h23'
                                </div>
                                TB từ khi khách đặt hàng tới khi mua thành công (gồm Thứ Bẩy và Chủ Nhật).
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                            <div class="rate-out">
                                <i class="fa-solid fa-check" style="font-size:60px"></i>
                                <div class="rate-detail">
                                    <span class="increment">98</span>%
                                </div>
                                Tỉ lệ đơn nhập thành công (ngoài ra là các đơn hết hàng do người bán).
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                            <div class="rate-out">
                                <i class="fa-solid fa-clock" style="font-size:60px"></i>
                                <div class="rate-detail">
                                    <span class="increment">155</span>H8'
                                </div>
                                TB từ khi Quý khách đặt hàng tới khi hàng về HP.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="info">
        <div class="container">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="info-content">
                    <div class="head-text">
                        <b>Dịch vụ nhập hàng chuyên nghiệp từ</b>
                    </div>
                    <div class="info-detail">
                        <p>- Đặt đơn hàng thuận tiện nhanh chóng với nhiều tiện ích hỗ trợ.</p>
                        <p>- Quản lý đơn hàng, Vận chuyển, Tài chính chuyên nghiệp, dễ dàng theo dõi.</p>
                        <p>- Có chính sách bảo hiểm rủi ro hàng hóa.</p>
                        <p>- Đội ngũ nhân viên hỗ trợ chăm sóc chu đáo nhiệt tình 24/7.</p>
                        <p>- Mục tiêu chính là thúc đẩy hợp tác thành công và cùng có lợi nhuận.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        var dem = [0, 0, 0];
        $(window).scroll(function() {
            var top = $(window).scrollTop();
            $(".increment").each(function(index) {
                if (dem[index] == 0) {
                    var vi_tri = $(this).parent().parent().parent().position().top;
                    var so = $(this).text();
                    var obj = $(this);
                    if ((top >= vi_tri - 300) && (top <= vi_tri - 200)) {
                        dem[index]++;
                        var k = 0;
                        var id = setInterval(frame, 20);
                        function frame() {
                            if (k >= so) {
                                clearInterval(id);
                            } else {
                                if (so <= 10) {
                                    k = k + 0.1;
                                    var h = Math.floor(k);
                                    obj.text(h);
                                } else {
                                    k++;
                                    obj.text(k);
                                }
                            }
                        }
                    }
                }
            });
        });
    </script>

    <footer>
        <div class="container">
            <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
                <div class="div-h3"><h4><b>Menu</b></h4></div>
                <ul class="list-info">
                    <li class="item-list"><a href="/baogia">Biểu phí</a></li>
                    <li class="item-list"><a href="/policies">Quy định chính sách</a></li>
                </ul>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <div class="list-div">
                    <div><h4><b>Văn phòng Hải Phòng</b></h4></div>
                    <div class="right-div">0865150693</div>
                    <div class="right-div">đường Trần Nguyên Hãn, quận Lê Chân, Thành phố Hải Phòng</div>
                </div>
            </div>
        </div>
    </footer>

    <script type="text/javascript" src="asset/thqc/LTE/plugins/ordertietkiemjs/frontend.js"></script>
    <script src="asset/ordertietkiem/parallax.js"></script>
    <style>
        @media (min-width: 992px) {
            .modal-lg {
                width: 1100px;
            }
        }
    </style>

    <script type="text/javascript">
        $('.parallax-img').parallax({
            speed: 0.2
        });
    </script>
</body>
</html>
