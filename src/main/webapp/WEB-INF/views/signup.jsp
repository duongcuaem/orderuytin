<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OrderUyTin</title>
    <link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">
    <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/additional-methods.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.1.0/mdb.min.css" rel="stylesheet" />
    <style>
        .error {
            color: red;
        }
        .form-container {
            display: flex;
            justify-content: space-between;
        }
        .form-column {
            flex: 1;
            margin-right: 10px;
        }
        .form-column:last-child {
            margin-right: 0;
        }
    </style>
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
                                    <c:if test="${not empty message}">
                                        <div style="color: red" class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">${message}</div>
                                    </c:if>
                                    <form:form method="post" class="row g-3 needs-validation" action="/create" modelAttribute="userRegistrationDto" id="registrationForm">
                                        <div class="form-container">
                                            <div class="form-column">
                                                <!-- User fields -->
                                                <div class="mb-3">
                                                    <label for="username" class="form-label">Tên đăng nhập</label>
                                                    <form:input path="user.username" class="form-control" id="username" placeholder="Hãy nhập tên đăng nhập" required="true"/>
                                                    <form:errors cssClass="error" path="user.username"></form:errors>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="password" class="form-label">Mật khẩu</label>
                                                    <form:input type="password" path="user.password" class="form-control" id="password" placeholder="Hãy nhập mật khẩu" required="true" minlength="6"/>
                                                    <form:errors cssClass="error" path="user.password"></form:errors>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="rePassword" class="form-label">Nhập lại mật khẩu</label>
                                                    <form:input type="password" path="rePassword" class="form-control" id="rePassword" placeholder="Nhập lại mật khẩu" required="true" equalTo="#password"/>
                                                    <form:errors cssClass="error" path="rePassword"></form:errors>
                                                </div>
                                            </div>
                                            <div class="form-column">
                                                <!-- UserProfile fields -->
                                                <div class="mb-3">
                                                    <label for="fullName" class="form-label">Họ và tên</label>
                                                    <form:input path="userProfile.fullName" class="form-control" id="fullName" placeholder="Hãy nhập họ và tên" required="true"/>
                                                    <form:errors cssClass="error" path="userProfile.fullName"></form:errors>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="email" class="form-label">Email</label>
                                                    <form:input type="email" path="userProfile.email" class="form-control" id="email" placeholder="Hãy nhập địa chỉ email" required="true" email="true"/>
                                                    <form:errors cssClass="error" path="userProfile.email"></form:errors>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="address" class="form-label">Địa chỉ</label>
                                                    <form:input path="userProfile.address" class="form-control" id="address" placeholder="Hãy nhập địa chỉ" required="true"/>
                                                    <form:errors cssClass="error" path="userProfile.address"></form:errors>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="phone" class="form-label">Số điện thoại</label>
                                                    <form:input path="userProfile.phone" class="form-control" id="phone" placeholder="Hãy nhập số điện thoại" required="true" minlength="10" maxlength="11"/>
                                                    <form:errors cssClass="error" path="userProfile.phone"></form:errors>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                            <button type="submit" class="btn btn-primary btn-lg">Đăng ký</button>
                                        </div>
                                    </form:form>
                                </div>
                                <div class="col-md-9 col-lg-6 col-xl-5">
                                    <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp" class="img-fluid" alt="Sample image">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<script>
    $(document).ready(function() {
        $('#registrationForm').validate({
            rules: {
                "user.username": {
                    required: true,
                    minlength: 3
                },
                "user.password": {
                    required: true,
                    minlength: 6
                },
                "rePassword": {
                    required: true,
                    equalTo: "#password"
                },
                "userProfile.fullName": {
                    required: true,
                    minlength: 3
                },
                "userProfile.email": {
                    required: true,
                    email: true
                },
                "userProfile.address": {
                    required: true
                },
                "userProfile.phone": {
                    required: true,
                    minlength: 10,
                    maxlength: 11
                }
            },
            messages: {
                "user.username": {
                    required: "Vui lòng nhập tên đăng nhập",
                    minlength: "Tên đăng nhập phải có ít nhất 3 ký tự"
                },
                "user.password": {
                    required: "Vui lòng nhập mật khẩu",
                    minlength: "Mật khẩu phải có ít nhất 6 ký tự"
                },
                "rePassword": {
                    required: "Vui lòng nhập lại mật khẩu",
                    equalTo: "Mật khẩu nhập lại không khớp"
                },
                "userProfile.fullName": {
                    required: "Vui lòng nhập họ và tên",
                    minlength: "Họ và tên phải có ít nhất 3 ký tự"
                },
                "userProfile.email": {
                    required: "Vui lòng nhập địa chỉ email",
                    email: "Địa chỉ email không hợp lệ"
                },
                "userProfile.address": {
                    required: "Vui lòng nhập địa chỉ"
                },
                "userProfile.phone": {
                    required: "Vui lòng nhập số điện thoại",
                    minlength: "Số điện thoại phải có ít nhất 10 ký tự",
                    maxlength: "Số điện thoại không được vượt quá 11 ký tự"
                }
            },
            errorElement: 'div',
            errorPlacement: function(error, element) {
                error.addClass('error');
                error.insertAfter(element);
            },
            highlight: function(element, errorClass, validClass) {
                $(element).addClass('is-invalid').removeClass('is-valid');
            },
            unhighlight: function(element, errorClass, validClass) {
                $(element).addClass('is-valid').removeClass('is-invalid');
            }
        });
    });
</script>

</body>
</html>
