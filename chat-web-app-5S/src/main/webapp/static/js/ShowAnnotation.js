
// document.getElementById("loginForm").addEventListener("submit", function (event) {
//    event.preventDefault();
//    
//    var formData = new FormData();
//    formData.append("username", document.getElementById("inputUsername").value);
//    formData.append("password", document.getElementById("inputPassword").value);
//    
//    var xhr = new XMLHttpRequest();
//    xhr.open("POST", "/login", true);
//    
//    xhr.onreadystatechange = function () {
//        if (xhr.readyState === 4) {
//            if (xhr.status === 200) {
//                var response = xhr.responseText;
//                if (response === "success") {
//                    showAnnotation('Thành công!', 'Đăng nhập thành công', 1)
//                } else {
//                    showAnnotation('Thất bại!', 'Đăng nhập thất bại', 0)
//                }
//            } else {
//                showAnnotation('Thất bại!', 'Có lỗi xảy ra khi đăng nhập', 0)
//            }
//        }
//    };
//    
//    xhr.send(formData);
//});
//





//ham show
// showAnnotation('Thành công!', 'Đăng nhập thành công', 1)
function showAnnotation(sub, cont, type) {
    // sub: tieu de tb
    // cont: noi dung
    // type: thanh cong hay that bai

    let type_text;
    if (type == 1) {
        type_text = 'success';
    } else {
        type_text = 'error';
    }
    Swal.fire({
        icon: type_text,
        title: sub,
        text: cont,
    })
}