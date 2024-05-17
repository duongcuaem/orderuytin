<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
    <link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
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
            $("#CNYrateVND").change(function() {
                $("#totalCNY").val((Number($("#price").val()) * Number($("#quantity").val())).toFixed(2));
                $("#totalVND").val((Number($("#totalCNY").val()) * Number($("#CNYrateVND").val())).toFixed(0));
            });
        });
    </script>
</head>
<body style="background-color: black">
<!-- ! Body -->
<div class="page-flex">
    <!-- ! Sidebar -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp"></jsp:include>
    <div class="main-wrapper">
        <!-- ! Main nav -->
        <jsp:include page="/WEB-INF/views/common/mainnav.jsp"></jsp:include>

        <!-- ! Main -->
        <div style="padding:10px">
        <main class="main users chart-page" id="skip-target">
            <div class="container">
                <p style="color: red">${message}</p>
                  <p style="text-align:center;margin-bottom: 10px;font-size:50px">TẠO ĐƠN HÀNG</p>
                    <div class="row stat-cards">
                        <div class="col-md-12 col-xl-12">
    <form:form method="post" action="/backend/item/create" modelAttribute="itemDAO">
        <article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">
                <div style="display:flex;flex-direction:column">
                    <div style="margin:5px" >
                        <select name="itemUserName" path="itemUserName">
                            <c:forEach items="${listUser}" var="u">
                                <option value="${u.userName}">${u.userName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div style="display:flex;flex-direction:column;color:yellow">
                        <div style="display:flex" >
                            <div style="display:flex;flex-direction:column;width:30%;height:100%">
                                    <div><img id="outputImage" alt="Preview" style="width:95px;height:200px;margin:5px"/> </div>
                                    <input type="text" class="form-control" id="fileuploadName" name="image" value="" path="image" hidden />
                                    <input type="file" class="form-control" id="fileUploadId" name="file" style="width:90px;margin:5px" value=""/><%-- thẻ input chon ảnh--%>
                            </div>
                            <div style="display:flex;flex-direction:column;justify-content: space-evenly;width:30%;color:red">
                                <div>   <label for="link" class="form-label"><p style="color:red">Link</p> </label> </div>
                                <div>   <label for="describle" class="form-label"><p style="color:red">Miêu tả</p></label> </div>
                                <div>   <label for="price" class="form-label"><p style="color:red">Giá </p></label>  </div>
                                <div>   <label for="quantity" class="form-label"><p style="color:red">Số lượng</p></label>  </div>
                                <div>   <label for="CNYrateVND" class="form-label"><p style="color:red">Tỉ giá</p></label>  </div>
                            </div>
                            <div style="display:flex;flex-direction:column;justify-content:space-between;width:30%" >
                                <input type="text"  id="link" name="link"  value=""   path="link"  style="width:95%;margin-top:10px"/> <br>
                                <form:errors cssClass="error" path="link"></form:errors>
                                <input type="text"  id="describle"     name="describle"      value=""   path="describle"  style="width:95%"   />  <br>
                                <input type="text"  id="price"  name="price"   value=""   path="price" style="width:95%" />  <br>
                                <form:errors cssClass="error" path="price"></form:errors>
                                <input type="text"  id="quantity"  name="quantity"   value=""   path="quantity" style="width:95%" />  <br>
                                <form:errors cssClass="error" path="quantity"></form:errors>
                                <input type="text"  id="CNYrateVND" name="CNYrateVND"  value="3620"   path="CNYrateVND"  style="width:95%"/> <br>
                                <input type="text"  id="itemStatus" name="itemStatus" value="Cho xu ly" path="itemStatus"  hidden/>  <br>
                            </div>
                        </div>
                        <div style="display:flex;flex-direction:row;width:100%;margin:10px">
                            <div style="width:50%">   <label for="totalCNY" class="form-label"><p style="color:red">Thành tiền (Tệ) </p></label>  </div>
                            <input type="text"  id="totalCNY"     name="totalCNY"      value=""   path="totalCNY"  style="width:150px"   />  <br>
                        </div>
                        <div style="display:flex;flex-direction:row;width:100%;margin:10px">

                        <div style="width:50%">   <label for="totalVND" class="form-label"><p style="color:red">Thành tiền (Việt) </p></label>  </div>
                        <input type="text"  id="totalVND"     name="totalVND"      value=""   path="totalVND"  style="width:150px"   />  <br>
                        </div>
                    </div>
                </div>
                <div style="margin-left:30%"> <input  type="submit" value="Mua ngay"style="padding:10px;color:yellow;background-color:black;font-size:20px;font-weight:bold;border-radius:10px;border-style:solid;border-width: thin;border-color:white" /> </div>
        </article>
    </form:form>
                        </div>
                    </div>
            </div>
        </main>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
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


