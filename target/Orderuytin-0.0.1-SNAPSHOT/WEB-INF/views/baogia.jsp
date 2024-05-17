<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bảng gi&aacute;</title>
    <meta name="description" content="">
    <meta name="keywords" content="dat hang trung quoc, mua hang trung quoc, van chuyen hang">
    <meta charset="utf-8">
    <meta name="author" content="order">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

    <!-- Load Core CSS
    =====================================-->
    <link rel="stylesheet" href="asset/gdqc/assets/css/core/bootstrap.min.css">
    <link rel="stylesheet" href="asset/gdqc/assets/css/core/animate.min.css">

    <script src="asset/gdqc/assets/js/core/jquery.min.js"></script>
    <script src="asset/gdqc/assets/js/core/bootstrap.min.js"></script>
	<link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">
    <link rel="stylesheet" href="asset/frontend/css/index_01.css">
    <style>
		body {
			font-size: 18px;
			background-color: whitesmoke;
		}
		.price-info {
			background-color: white;
		}
		.div-large {
			font-size: 24px;
			padding-top: 80px; 
		}
		.list-right {
			list-style-type: none;
			left: 20px;
		}
		.div-right {
			margin-left: 20px;
		}
		.right-div {
			margin-left: 20px;
		} 
		.div-relative {
			position: relative;
		}
		@media  all and (min-width: 768px) {
		   .div-fix {
		   		position: fixed;
		   		z-index: 1;
			}
		}
		.ul-list > li > a {
			color: #ff6600;
		}
		.ul-list > li > a:hover {
			color: #00FF00;
		}
		.li-right {
			padding-left: 20px;
		}
	</style>
    <style type="text/css">
    	
    </style>
</head>
<body>
    <div class="nav-margin">
	<div id='div-fix' class="">
		<nav class="navbar navbar-default navbar-fixed-top nav-head" role="navigation">
			<div class="container-fluid">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-ex1-collapse">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="brand-logo" href="https://ordertietkiem.com">
						<img src="/orderuytin/orderuytin.jpg" alt="image" style="margin-top: -15px;height: 85px;width:200px">
					</a>
				</div>
	    	
	    			<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse navbar-ex1-collapse">
					<ul class="nav navbar-nav navbar-right">
						<li>
							<a class="a-decorate" href="/">
								Trang chủ
							</a>
						</li>
						<li>
							<a class="a-decorate" href="/baogia">
								Biểu phí
							</a>
						</li>
						<li>
							<a class="a-decorate" href="/policies">
								Quy định và Chính sách
							</a>
						</li>
						<%--                        <li>--%>
						<%--                            <a href="https://chrome.google.com/webstore/detail/illhjdkllefbcaknkofdjhodigjnkcgi/" target="_blank">--%>
						<%--                                Công cụ--%>
						<%--                            </a>--%>
						<%--                        </li>--%>
						<%--                        <li>--%>
						<%--                            <a class="a-decorate" href="www.orderuytin.com/news">--%>
						<%--                                Tin tức--%>
						<%--                            </a>--%>
						<%--                        </li>--%>
						<%--                        <li>--%>
						<%--                            <a class="a-decorate" href="www.orderuytin.com/notification">--%>
						<%--                                Thông báo--%>
						<%--                            </a>--%>
						<%--                        </li>--%>
						<%--                        <li>--%>
						<%--                            <a class="a-decorate" href="www.orderuytin.com/instruction">--%>
						<%--                                Hướng dẫn--%>
						<%--                            </a>--%>
						<%--                        </li>--%>
						<li>
							<a class="brand-logo" href="/signup">Đăng ký </a>
						</li>
						<li>
							<a class="a-decorate" href="/doLogin">
								Đăng nhập
							</a>
						</li>
					</ul>
				</div><!-- /.navbar-collapse -->
	    		</div>
	    	</nav>
	    </div>
</div>    	<div class="div-content">
    			<div class="">
		<div class="container">
			<div class="col-xs-12 col-sm-9 price-info">
				<div id="list-price">
					<div class="div-large"><b>1. Những chi phí trên 1 đơn hàng order</b></div>
					<div>
						<table class="table table-bordered">
							<tr class="success">
								<td></td>
								<td>Chi tiết</td>
							</tr>
							<tr>
								<td>1. Phí ship nội địa Trung Quốc</td>
								<td>Phí chuyển hàng từ nhà cung cấp đến kho TQ của chúng tôi</td>
								
							</tr>
							<tr>
								<td>2. Chúng tôi thu</td>
								<td>Giá tiền trên web x tỉ giá (luôn có tỉ giá cạnh tranh nhất thị trường, đặc  biệt là KHÔNG THU BẤT KÌ % PHÍ DỊCH VỤ NÀO)
									và cước vận chuyển nhanh tính theo kg</td>
								
							</tr>
							<tr>
								<td>3. Phí đóng gỗ (Tùy chọn)</td>
								<td>Đóng gỗ ngoài kiện để chống móp méo</td>
						
							</tr>
							<tr class="hidden">
								<td>4. Phí kiểm đếm (Tùy chọn)</td>
								<td>Chúng tôi kiểm hàng tại kho TQ để đảm bảo đúng hàng đã mua</td>
								
							</tr>
							
						</table>
					</div>
				</div>
				<div id="">
					<div class="div-large"><b>2. Phí ship nội địa Trung Quốc</b></div>
					<div class="div-right">
						<table class="table table-bordered">
							<tr class="success">
								<td></td>
								<td>Phí ship Trung Quốc</td>
							</tr>
							<tr>
								<td>Chi tiết</td>
								<td>Đây là mức phí cần để chuyển hàng từ shop TQ đến kho của chúng tôi tại QC(nếu có)</td>
							</tr>
						</table>
					</div>
				</div>
				<div id="service-price">
					<div class="div-large"><b>3. Phí mua hàng và Phí vận chuyển</b></div>
					<div class="div-right">
						<div class="div-large"><b>Phí mua hàng và Phí vận chuyển THƯỜNG</b></div>
						<table class="table table-bordered text">
							<tr class="success">
								<td>Phí mua hàng <br></td>
								<td>Hải Phòng(đ/kg)</td>
								<td>Các tỉnh thành khác(đ/kg)</td>
							</tr>
							<tr>
								<td class="text-right">0%</td>
								<td class="text-right">30.000<sup>đ</sup>(có fix cho hàng nặng)</td>
								<td class="text-right">30.000<sup>đ</sup>(có fix cho hàng nặng)+ Ship liên tỉnh(bên chuyển phát nhanh VN thu)</td>
							</tr>
						</table>
						<p><b>Lưu ý: </b>Với các kiện hàng nhẹ và cồng kềnh, quy đổi theo công thức: Dài*Rộng*Cao* Tỉ giá m3 .</p>
						<p class="" style="padding-left: 58px;">Giá vận chuyển có thể thay đổi tính theo thời điểm hàng nhập kho Việt Nam</p>
						<p><b>Ưu điểm: Giá vận chuyển rẻ hơn, thời gian hàng về nhanh</b></p>
						<div class="div-large"><b>Phí mua hàng và Phí vận chuyển NHANH(4-7 ngày)</b></div>
						<table class="table table-bordered text">
							<tr class="success">
								<td>Phí mua hàng <br></td>
								<td>Hải Phòng(đ/kg)</td>
								<td>Các tỉnh thành khác(đ/kg)</td>
							</tr>
							<tr>
								<td class="text-right">0%</td>
								<td class="text-right">45.000<sup>đ</sup>(có fix cho hàng nặng)</td>
								<td class="text-right">45.000<sup>đ</sup>(có fix cho hàng nặng)+ Ship liên tỉnh(bên chuyển phát nhanh VN thu)</td>
							</tr>
						</table>
						<p><b>Lưu ý: </b>Không nhận hàng cồng kềnh nặng.</p>
						<p class="" style="padding-left: 58px;">Giá vận chuyển có thể thay đổi tính theo thời điểm hàng nhập kho Việt Nam</p>
						<p><b>Ưu điểm: Thời gian hàng về nhanh hơn, ổn định hơn và Ship nội địa TQ rẻ hơn</b></p>
											</div>
				</div>
				<div id="wood-price">
					<div class="div-large"><b>4. Phí đóng gỗ (Tùy chọn)</b></div>
					<div class="div-right">
						<table class="table table-bordered">
							<tr class="success">
								<td></td>
								<td>Kg đầu tiên</td>
								<td>Kg tiếp theo</td>
							</tr>
							<tr>
								<td>Phí đóng kiện</td>
								<td>20 tệ</td>
								<td>0.8 tệ</td>
							</tr>
						</table>
					</div>
				</div>

			</div>
		</div>
	</div>
    	</div>
   <footer>
	   <div class="container">
		   <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
			   <div class="div-h3"><h4><b>Menu</b></h4></div>
			   <ul class="list-info">
				   <li class="item-list">
					   <a href="/baogia">Biểu phí</a>
				   </li>
				   <li class="item-list">
					   <a href="/policies">Quy định chính sách</a>
				   </li>
				   <%--				<li class="item-list">--%>
				   <%--					<a href="https://chrome.google.com/webstore/detail/illhjdkllefbcaknkofdjhodigjnkcgi/">Công cụ đặt hàng</a>--%>
				   <%--				</li>--%>
				   <li class="item-list">
					   <a href="/instruction">Hướng dẫn</a>
				   </li>
			   </ul>
		   </div>

		   <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
			   <div class="list-div">
				   <div><h4><b>Văn phòng Hải Phòng</b></h4></div>
				   <div class="right-div">0865150693</div>
				   <div class="right-div">đường Trần Nguyên Hãn , quận Lê Chân , Thành phố Hải Phòng</div>
			   </div>
		   </div>
	   </div>
   </footer>
</body>
		<script>
			$('#show-send-price').click(function(){
				$('#send-price').removeClass('hidden');
			});
	</script>
</html>
