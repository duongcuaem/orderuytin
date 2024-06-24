<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
    <!-- MDB -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.3.0/mdb.min.css" rel="stylesheet"/>
    <!-- MDB -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.3.0/mdb.min.js"></script>
    <link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">
    <style>
        .divider:after,
        .divider:before {
            content: "";
            flex: 1;
            height: 1px;
            background: #eee;
        }
        .h-custom {
            height: calc(100% - 73px);
        }
        @media (max-width: 450px) {
            .h-custom {
                height: 100%;
            }
        }
        .error {
            color: red;
        }
        .success {
            color: green;
        }
    </style>
</head>
<body>
<section class="vh-100">
    <div class="container-fluid h-custom">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">
                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-registration/draw1.webp" class="img-fluid" alt="Sample image">
            </div>
            <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                    <p class="lead fw-normal mb-0 me-3">Đăng nhập</p>
                </div>
                <div class="divider d-flex align-items-center my-4">
                    <p class="text-center fw-bold mx-3 mb-0"></p>
                </div>
                <p id="message" class="error"></p>
                <form id="loginForm" class="row g-3 needs-validation">
                    <!-- Email input -->
                    <div class="form-outline mb-4">
                        <input type="text" id="username" value="" name="username" class="form-control form-control-lg" placeholder="Hãy nhập số điện thoại mà bạn dùng để đăng kí tài khoản." />
                        <label class="form-label" for="username">Tài khoản</label>
                    </div>
                    <!-- Password input -->
                    <div class="form-outline mb-3">
                        <input type="password" id="password" name="password" class="form-control form-control-lg" placeholder="Hãy nhập mật khẩu" />
                        <label class="form-label" for="password">Mật khẩu</label>
                    </div>
                    <button type="submit" class="btn btn-primary btn-lg" style="padding-left: 2.5rem; padding-right: 2.5rem;">Đăng nhập</button>
                </form>

                <div class="text-center mt-4">
                    <a href="/oauth2/authorization/google" class="btn btn-danger btn-block btn-social">
                        <i class="fab fa-google"></i> Đăng nhập với Google
                    </a>
                    <a href="/oauth2/authorization/facebook" class="btn btn-primary btn-block btn-social">
                        <i class="fab fa-facebook-f"></i> Đăng nhập với Facebook
                    </a>
                </div>

                <div class="text-center text-lg-start mt-4 pt-2">
                    <p class="small fw-bold mt-2 pt-1 mb-0">Bạn chưa có tài khoản?
                        <a href="/signup" class="link-danger">Đăng ký</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
    <div class="d-flex flex-column flex-md-row text-center text-md-start justify-content-between py-4 px-4 px-xl-5 bg-primary">
        <!-- Copyright -->
        <div class="text-white mb-3 mb-md-0">
            Copyright © 2023. Mr.Chill.
        </div>
    </div>
</section>

<script type="text/javascript">
    $(document).ready(function() {
        $('#loginForm').on('submit', function(event) {
            event.preventDefault(); // Ngăn chặn form submit mặc định
            var formData = {
                userName: $('#username').val(),
                password: $('#password').val()
            };

            $.ajax({
                type: 'POST',
                url: '/api/loginUser',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: function(response) {
                    if (response.success) {
                        $('#message').removeClass('error').addClass('success').text('Đăng nhập thành công!');
                        localStorage.setItem('token', response.token);
                        // Thực hiện điều gì đó khi đăng nhập thành công, ví dụ: chuyển hướng trang
                        window.location.href = response.url;
                    } else {
                        $('#message').removeClass('success').addClass('error').text(response.message);
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    $('#message').removeClass('success').addClass('error').text('Đã xảy ra lỗi, vui lòng thử lại sau.');
                }
            });
        });
    });
</script>
</body>
</html>
