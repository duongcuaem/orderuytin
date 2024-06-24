<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>

</body>
<script>
    const token = getParameterByName('token');
    console.log("DuongDx: " + token)
    if (token != null) {
        // Set token vào bộ nhớ của máy
        localStorage.setItem('token', token);
        console.log(token)
        // Gọi vào trang Kiểm tra xem token này thuộc Role nào và chuyển hướng tại BackEnd.
        userRedirection(token);
        // // nếu đúng sẽ chạy về trang chủ
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

    async function userRedirection(token) {
        console.log(token);
        try {
            const url = "http://localhost:8080/userRedirection";
            const response = await fetch(url, {
                method: 'GET',
                headers: {
                    'Authorization': `Token ` + token
                }
            });
            if (!response.ok) {
                throw new Error('Network response was not ok');
            } else {
                const redirectUrl = await response.text();
                console.log(redirectUrl);
                window.location.href = redirectUrl;
            }
        } catch (error) {
            console.error('Có lỗi xảy ra:', error);
        }
    }

</script>
</html>
