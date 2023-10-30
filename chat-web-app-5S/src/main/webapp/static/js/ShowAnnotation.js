 
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
        text: cont
    })
}