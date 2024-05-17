<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
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
</style>
<script type="text/javascript">
    $(document).ready(function() {
        var userName = document.getElementById('form3Example3');
        $("form").submit(function(){
            localStorage.setItem('itemUserName', userName.value);
        });

    });
</script>
</head>
<body>
<section class="vh-100">
    <div class="container-fluid h-custom">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">
                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-registration/draw1.webp" class="img-fluid" alt="Sample image">
            </div>
            <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start"><p class="lead fw-normal mb-0 me-3">Đăng nhập</p></div>
                <div class="divider d-flex align-items-center my-4"><p class="text-center fw-bold mx-3 mb-0"></p></div>
                <p style="color:red">${message} </p>
<form:form method="post" class="row g-3 needs-validation" action="/authenticateUser" >
                    <!-- Email input -->
    <div class="form-outline mb-4">
        <input type="text" id="form3Example3" value="" name="username" class="form-control form-control-lg" placeholder="Hãy nhập số điện thoại mà bạn dùng để đăng kí tài khoản." />
        <label class="form-label" for="form3Example3">Tài khoản</label>
    </div>
    <!-- Password input -->
    <div class="form-outline mb-3">
        <input type="password" id="form3Example4" name="password" class="form-control form-control-lg" placeholder="Hãy nhập mật khẩu" />
        <label class="form-label" for="form3Example4">Mật khẩu</label>
    </div>
      <button type="submit"  class="btn btn-primary btn-lg" style="padding-left: 2.5rem; padding-right: 2.5rem;">Đăng nhập</button>
</form:form>

                    <div class="text-center text-lg-start mt-4 pt-2">
                        <p class="small fw-bold mt-2 pt-1 mb-0" style="fontsize:100px">Bạn chưa có tài khoản?
                            <a href="/signup" class="link-danger">Đăng ký</a> </p>
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
</body>

</html>