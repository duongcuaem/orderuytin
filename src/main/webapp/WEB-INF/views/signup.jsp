<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OrderUyTin</title>
    <link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">
    <script src="https://code.jquery.com/jquery-2.2.4.min.js" ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js" ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/additional-methods.min.js" ></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.1.0/mdb.min.css" rel="stylesheet" />
    <style>
        .error{
            color:red
        }
    </style>
    <script>
        $(document).ready(function () {
            $("form").validate({
                rules: {
                    userName: {
                        required: true,
                        minlength: 3
                    },
                    email: {
                        required: true,
                        email: true
                    },
                    address: {
                        required: true
                    },
                    phone: {
                        required: true,
                        digits: true,
                        minlength: 10,
                        maxlength: 15
                    },
                    password: {
                        required: true,
                        minlength: 6
                    },
                    rePassword: {
                        required: true,
                        equalTo: "#password"
                    }
                },
                messages: {
                    userName: {
                        required: "Vui lòng nhập họ và tên",
                        minlength: "Họ và tên phải có ít nhất 3 ký tự"
                    },
                    email: {
                        required: "Vui lòng nhập email",
                        email: "Email không hợp lệ"
                    },
                    address: {
                        required: "Vui lòng nhập địa chỉ"
                    },
                    phone: {
                        required: "Vui lòng nhập số điện thoại",
                        digits: "Số điện thoại chỉ chứa các chữ số",
                        minlength: "Số điện thoại phải có ít nhất 10 chữ số",
                        maxlength: "Số điện thoại không được vượt quá 15 chữ số"
                    },
                    password: {
                        required: "Vui lòng nhập mật khẩu",
                        minlength: "Mật khẩu phải có ít nhất 6 ký tự"
                    },
                    rePassword: {
                        required: "Vui lòng nhập lại mật khẩu",
                        equalTo: "Mật khẩu nhập lại không khớp"
                    }
                },
                errorElement: "div",
                errorPlacement: function (error, element) {
                    error.addClass("invalid-feedback");
                    error.insertAfter(element);
                },
                highlight: function (element, errorClass, validClass) {
                    $(element).addClass("is-invalid").removeClass("is-valid");
                },
                unhighlight: function (element, errorClass, validClass) {
                    $(element).addClass("is-valid").removeClass("is-invalid");
                }
            });
        });
    </script>
</head>
<body>

<div class="container">
    <section class="vh-100" style="background-color: #eee;">
        <div class="container h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-lg-12 col-xl-11">
                    <div class="card text-black" style="border-radius: 25px;">
                        <div class="card-body p-md-5">
                            <div class="row justify-content-center">
                                <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">
                                    <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Đăng ký tài khoản</p>
                                    <p style="color: red" class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">${message}</p>
                                    <form:form method="post" class="row g-3 needs-validation" action="/create" modelAttribute="users">
                                        <div class="col-md-6">
                                            <label for="userName" class="form-label">Họ và tên</label>
                                            <input type="text" class="form-control" id="userName" name="userName" path="userName" placeholder="Hãy nhập tên" />
                                        </div>
                                        <div class="col-md-6">
                                            <label for="email" class="form-label">Email</label>
                                            <input type="text" class="form-control" id="email" name="email" value="" placeholder="Hãy nhập địa chỉ email " path="email" />
                                        </div>
                                        <div class="col-md-6">
                                            <label for="address" class="form-label">Địa chỉ</label>
                                            <input type="text" class="form-control" name="address" id="address" value="" placeholder="Hãy nhập địa chỉ " path="address" />
                                        </div>
                                        <div class="col-md-6">
                                            <label for="phone" class="form-label">Số điện thoại</label>
                                            <input type="text" id="phone" name="phone" class="form-control m-input" value="" placeholder="Hãy nhập số điện thoại " path="phone"/>
                                        </div>
                                        <div style="display:none">
                                            <input type="text" name="role" path="role" value="ROLE_USER" />
                                            <input type="text" name="STATUS" path="STATUS" value="1" />
                                            <input type="text" name="rate" path="rate" value="3580" />
                                            <input type="text" name="rateKg" path="rateKg" value="30000" />
                                            <input type="text" name="rateM3" path="rateM3" value="2800000" />
                                        </div>
                                        <div class="col-md-6">
                                            <label for="password" class="form-label">Mật khẩu</label>
                                            <input type="password" class="form-control" id="password" name="password" value="" path="password" />
                                            <form:errors cssClass="error" path="password"></form:errors>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="rePassword" class="form-label">Nhập lại Mật khẩu</label>
                                            <input type="password" class="form-control" id="rePassword" name="rePassword" value="" path="rePassword" />
                                            <form:errors cssClass="error" path="rePassword"></form:errors>
                                        </div>
                                        <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                            <button type="submit" class="btn btn-primary btn-lg">Đăng ký</button>
                                        </div>
                                    </form:form>
                                </div>
                                <div class="col-md-9 col-lg-6 col-xl-5">
                                    <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
                                         class="img-fluid" alt="Sample image">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

</body>

</html>
