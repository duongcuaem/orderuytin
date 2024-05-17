<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
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
    <main class="main users chart-page" id="skip-target">
      <div class="container">
        <div style="display:flex;flex-direction:column;">
          <div style="font-size:30px;text-align:center"><p >CHI TIẾT ĐƠN HÀNG</p></div>
        </div>
        <div class="row stat-cards">
            <div style="margin:10px">
                <form:form method="post" action="/backend/item/saveItem"  modelAttribute="itemDAO">
              <article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">
                <div class="row">
                  <div style="display:flex;flex-direction:column;margin:2px">
                    <div style="display:flex;flex-direction:row">
                        <div style="display:flex;flex-direction:column;width:30%;height:100%">
                            <img id="outputImage" style="width:90px;height:200px;margin:5px"  src="<c:url value="/image/item/${item.image}" />" />
                            <input type="text" class="form-control" id="fileuploadName" name="image" value="${item.image}" path="image" hidden />
                            <input type="file" class="form-control" id="fileUploadId" name="file" style="width:90px;margin:5px" value=""/><%-- thẻ input chon ảnh--%>
                        </div>
                        <div style="display:flex;flex-direction:column;width:70%;">
                           <input type="text"  name="itemId"      value="${item.itemId}"     path="itemId" hidden/>
                           <input type="text"  name="orderId"     value="${item.orderId}"    path="orderId" hidden/>
                           <input type="text"  name="itemStatus"  value="${item.itemStatus}" path="itemStatus" hidden/>
                           <div style="display:flex;flex-direction:row;width:95%">
                               <div style="text-align:center;width:50%"><label >客户</label> </div>
                               <div style="width:50%;color:#5eff00"><input type="text"  name="itemUserName"  value="${item.itemUserName}" style="width:100%" path="itemUserName" /></div>
                           </div>

                           <div style="display:flex;flex-direction:row;width:95%">
                               <div style="text-align:center;width:50%"><label >描述</label> </div>
                               <div style="width:50%;color:#5eff00"><input type="text"   name="describle"  value="${item.describle}" style="width:100%" path="describle" /></div>
                           </div>

                           <div style="display:flex;flex-direction:row;width:95%">
                               <div style="text-align:center;width:50%"><a href="${i.link}"> 链接 </a></div>
                               <div style="width:50%;margin:5px"><input type="text" style="width:100%" name="link"  value="${item.link}"  path="link" />  <br></div>
                           </div>

                           <div style="display:flex;flex-direction:row;width:95%">
                               <div style="text-align:center;width:50%"><label>价格</label>  </div>
                               <div style="width:50%;margin:5px"><input type="text"  name="price"  value="${item.price}" style="width:100%" path="price" />  <br></div>
                           </div>

                           <div style="display:flex;flex-direction:row;width:95%" >
                               <div style="text-align:center;width:50%"><label>数量</label>  </div>
                               <div style="width:50%;margin:5px" ><input type="text"  name="quantity"   value="${item.quantity}" style="width:100%"  path="quantity" />  <br></div>
                           </div>

                           <div style="display:flex;flex-direction:row;width:95%">
                               <div style="text-align:center;width:50%"><label> 汇率</label> </div>
                               <div style="width:50%;margin:5px"><input type="text"   style="width:100%" name="CNYrateVND" value="${item.CNYrateVND}"  path="CNYrateVND" />  <br></div>
                           </div>

                           <div ><input type="submit"   style="color:yellow;background-color:black;font-size:20px;font-weight:bold;border-radius:10px;border-style:solid;border-width: thin;border-color:white" value="Cập nhật" /> </div>

                       </div>
                    </div>
                  </div>
                </div>

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