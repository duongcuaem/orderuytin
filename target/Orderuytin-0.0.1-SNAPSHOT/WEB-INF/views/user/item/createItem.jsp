<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/commonUsers/head.jsp"></jsp:include>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">
    <script>
        $(document).ready(function(){
            $("#price").change(function() {
                $("#totalCNY").val((Number($("#price").val()) * Number($("#quantity").val())).toFixed(2));
                $("#totalVND").val((Number($("#totalCNY").val()) * Number($("#CNYrateVND").val())).toFixed(0));
            });
            $("#quantity").change(function() {
                $("#totalCNY").val((Number($("#price").val()) * Number($("#quantity").val())).toFixed(2));
                $("#totalVND").val((Number($("#totalCNY").val()) * Number($("#CNYrateVND").val())).toFixed(0));
            });
        });
    </script>
    <script>
        $(document).ready(function(){
            $("#Cart").click( function addToCart(){
                document.getElementById('itemStatus').value = 'Gio hang';
                document.getElementById('form').submit();
            });
            $("#BuyIt").click( function addToCart(){
                document.getElementById('itemStatus').value = 'Cho xu ly';
                document.getElementById('form').submit();
            });
        });
    </script>
</head>
<body style="background-color: black">
<!-- ! Body -->
<div class="page-flex">
    <!-- ! Sidebar -->
    <jsp:include page="/WEB-INF/views/commonUsers/sidebar.jsp"></jsp:include>
    <div class="main-wrapper">
        <!-- ! Main nav -->
        <jsp:include page="/WEB-INF/views/commonUsers/mainnav.jsp"></jsp:include>

        <!-- ! Main -->
        <div style="padding:10px">
        <main class="main users chart-page" id="skip-target">
            <div class="container">
                <p style="color: red">${message}</p>
<h1 style="text-align:center;margin-bottom: 10px;color:#5eff00">TẠO ĐƠN HÀNG</h1>
<div class="row stat-cards">
    <div class="col-md-12 col-xl-12">
        <form:form method="post" action="/user/item/create" id="form" modelAttribute="itemDAO">
            <article class="stat-cards-item">
                <div style="display:flex;flex-direction:column;width:100%;align-items: center">
                   <input type="text" id="itemUserName" name="itemUserName" value="${loginUser.userName}"  path="itemUserName" hidden />
                    <div style="display:flex;flex-direction:column">
                        <div style="display:flex" >
                            <div style="display:flex;flex-direction:column;width:30%;height:100%">
                                <div><img id="outputImage" alt="Image" style="width:90px;height:200px;margin:5px"/> </div>
                                <input type="text" class="form-control" id="fileuploadName" name="image" value="" path="image" hidden />
                                <input type="file" class="form-control" id="fileUploadId" name="file" style="width:90px;margin:5px" value=""/><%-- thẻ input chon ảnh--%>
                                <div style="color:lawngreen"> Tỉgiá:${loginUser.rate}</div>
                            </div>
                            <div style="display:flex;flex-direction:column;justify-content: space-evenly;width:30%">
                                <div> Link</div>
                                <div> Miêu tả</div>
                                <div> Giá </div>
                                <div> Số lượng</div>

                            </div>
                            <div style="display:flex;flex-direction:column;justify-content:space-between;width:30%" >
                                <input type="text"  id="link" name="link"  value=""   path="link"  style="width:95%;margin-top:10px"/> <br>
                                <div style="color:#00ff15"><form:errors cssClass="error" path="link"></form:errors></div>
                                <input type="text"  id="describle"     name="describle"      value=""   path="describle"  style="width:95%"   />  <br>
                                <input type="text"  id="price"  name="price"   value=""   path="price" style="width:95%" />  <br>
                                <div style="color:#00ff15"><form:errors cssClass="error" path="price"></form:errors></div>
                                <input type="text"  id="quantity"  name="quantity"   value=""   path="quantity" style="width:95%" />  <br>
                                <div style="color:#00ff15"><form:errors cssClass="error" path="quantity"></form:errors></div>
                                <input type="text"  id="CNYrateVND" name="CNYrateVND"  value="${loginUser.rate}"   path="CNYrateVND" hidden />
                            </div>
                        </div>
                        <div style="display:flex;flex-direction:row;width:100%;margin:10px">
                            <div style="width:50%">Thành tiền (Tệ)</div>
                            <input type="text"  id="totalCNY"    value=""   style="width:150px"   />  <br>
                        </div>

                        <div style="display:flex;flex-direction:row;width:100%;margin:10px">
                            <div style="width:50%"> Thành tiền(Việt)</div>
                            <input type="text"  id="totalVND"  value=""  style="width:150px"   />  <br>
                        </div>
                    </div>
                    <input type="text"  id="itemStatus"  name="itemStatus" value=""   path="itemStatus" hidden  />  <br>

                    <div style="display:flex;flex-direction:row">
                        <div > <button class="form-btn primary-default-btn" id="Cart">Cho hàng vào giỏ</button> </div>
                        <div style="margin-left:20%"> <button class="form-btn primary-default-btn" id="BuyIt">Mua ngay</button></div>
                    </div>
                </div>
            </article>

        </form:form>
    </div>
</div>
            </div>
        </main>

        <jsp:include page="/WEB-INF/views/commonUsers/footer.jsp"></jsp:include>
    </div>
        <script>
            window.addEventListener("paste",e => {
                if(e.clipboardData.files.length>0){
                    const fileInput = document.querySelector('#fileUploadId');
                    fileInput.files = e.clipboardData.files;
                    if(e.clipboardData.files[0].type.startsWith("image/")){
                        setPreviewImage(e.clipboardData.files[0]);
                    }
                    var imagFile = e.clipboardData.files[0];
                    var reader = new FileReader();
                    reader.readAsDataURL(imagFile);
                    var data = new FormData();
                    data.append("file", imagFile, imagFile.name);
                    $.ajax({
                        type: "POST",
                        enctype: 'multipart/form-data',
                        url: "/user/item/upload",
                        data: data,
                        // prevent jQuery from automatically transforming the data into a query string
                        processData: false,
                        contentType: false,
                        cache: false,
                        timeout: 1000000,
                        success: function(data, textStatus, jqXHR) {
                            $("#fileuploadName").val(data);
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            alert("tải file thất bại")
                        }
                    });
                }
            });
            function setPreviewImage(file){
                const fileReader = new FileReader();
                fileReader.readAsDataURL(file);
                fileReader.onload = () => {
                    document.querySelector("#outputImage").src = fileReader.result;
                }
            }
        </script>
        <script>
            $('#fileUploadId').on("change", function () {
                var file = $(this)[0].files[0];
                var reader = new FileReader();
                reader.onload = function(){
                    var output = document.getElementById('outputImage');
                    output.src = reader.result;
                };
                reader.readAsDataURL(file);
                var data = new FormData();
                data.append("file", file, file.name);
                $.ajax({
                    type: "POST",
                    enctype: 'multipart/form-data',
                    url: "/backend/item/upload",
                    data: data,
                    // prevent jQuery from automatically transforming the data into a query string
                    processData: false,
                    contentType: false,
                    cache: false,
                    timeout: 1000000,
                    success: function(data, textStatus, jqXHR) {
                        $("#fileuploadName").val(data);
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert("tải file thất bại")
                    }
                });
            })
        </script>

    <!-- Chart library -->
    <script src="/plugins/chart.min.js"></script>
    <!-- Icons library -->
    <script src="/plugins/feather.min.js"></script>
    <!-- Custom scripts -->
    <script src="/js/script.js"></script>

</body>

</html>


