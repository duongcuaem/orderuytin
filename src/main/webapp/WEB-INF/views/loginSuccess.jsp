<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>

</body>
<script>
    const token = getParameterByName('token');
console.log(token)
    if (token != null) {
        // Set token vào bộ nhớ của máy
        localStorage.setItem('token', token);
        //setCookie("token", token, 1);
        console.log("ok đã chạy vào đây");
        // nếu đúng sẽ chạy về trang chủ
        //window.location.href = "home";
    }

    // Hàm để lấy giá trị của một tham số từ URL
    function getParameterByName(name, url = window.location.href) {
        name = name.replace(/[\[\]]/g, '\\$&');
        const regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)');
        const results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, ' '));
    }

    // Kiểm tra token còn hạn hay không
    function isTokenExpired(token) {
        const payload = JSON.parse(atob(token.split('.')[1]));
        const expirationTime = payload.exp * 1000; // exp là thời gian hết hạn tính bằng giây, cần nhân với 1000 để chuyển sang milliseconds
        return Date.now() > expirationTime;
    }

    // function setCookie(cname, cvalue, exdays) {
    //     var d = new Date();
    //     d.setTime(d.getTime() + (exdays*24*60*60*1000));
    //     var expires = "expires="+ d.toUTCString();
    //     document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
    // }

</script>
</html>
