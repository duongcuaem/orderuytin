<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Font Awesome -->
<link
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
        rel="stylesheet"
/>
<!-- Google Fonts -->
<link
        href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
        rel="stylesheet"
/>
<!-- MDB -->
<link
        href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.3.0/mdb.min.css"
        rel="stylesheet"
/>
<!-- MDB -->
<script
        type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.3.0/mdb.min.js"
></script>
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
<section class="vh-100">
    <div class="container-fluid h-custom">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-md-9 col-lg-6 col-xl-5">
                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
                     class="img-fluid" alt="Sample image">
            </div>
            <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">


                <form:form method="post" action="/backend/user/save" modelAttribute="userDAO">
                                <input type="text"  name="search"   path="search"   value=""    style="width:120px"/>
                                <input type="text"  name="password"     path="password"     value=""    style="width:120px"/>
                                <input type="text"  name="rePassword"   path="rePassword"   value=""    style="width:120px"/>
                            <div style="display:none">
                                <input type="text"  name="rate"         path="rate"        value="${User.rate}"     />
                                <input type="text"  name="rateKg"       path="rateKg"      value="${User.rateKg}"   />
                                <input type="text"  name="rateM3"       path="rateM3"      value="${User.rateM3}"   />
                                <input type="text"  name="userId"       path="userId"      value="${User.userId}"   />
                                <input type="text"  name="address"      path="address"     value="${User.address}"  />
                                <input type="text"  name="phone"        path="phone"       value="${User.phone}"    />
                                <input type="text"  name="role"         path="role"        value="${User.role}"     />
                                <input type="text"  name="email"        path="email"       value="${User.email}"    />
                                <input type="text"  name="STATUS"       path="STATUS"      value="${User.STATUS}"   />
                            </div>
                            <div><button type="submit" class="form-btn primary-default-btn">Đổi mật khẩu</button></div>
                        </div>
                </form:form>
            </div>
        </div>
    </div>
    <div
            class="d-flex flex-column flex-md-row text-center text-md-start justify-content-between py-4 px-4 px-xl-5 bg-primary">
        <!-- Copyright -->
        <div class="text-white mb-3 mb-md-0">
            Mr.Chill © 2023. All rights reserved.
        </div>
        <!-- Copyright -->

        <!-- Right -->
        <div>
            <a href="#!" class="text-white me-4">
                <i class="fab fa-facebook-f"></i>
            </a>
            <a href="#!" class="text-white me-4">
                <i class="fab fa-twitter"></i>
            </a>
            <a href="#!" class="text-white me-4">
                <i class="fab fa-google"></i>
            </a>
            <a href="#!" class="text-white">
                <i class="fab fa-linkedin-in"></i>
            </a>
        </div>
        <!-- Right -->
    </div>
</section>