const darkModeToggle = document.getElementById('darkModeToggle');
const body = document.body;

// Xử lý sự kiện khi chuyển đổi chế độ tối
darkModeToggle.addEventListener('change', () => {
    if (darkModeToggle.checked) {
        body.classList.add('dark-mode');
    } else {
        body.classList.remove('dark-mode');
    }
});

// Kiểm tra trạng thái ban đầu của chế độ tối
if (localStorage.getItem('darkMode') === 'enabled') {
    body.classList.add('dark-mode');
    darkModeToggle.checked = true;
} else {
    body.classList.remove('dark-mode');
    darkModeToggle.checked = false;
}

// Lưu trạng thái chế độ tối vào Local Storage
darkModeToggle.addEventListener('change', () => {
    if (darkModeToggle.checked) {
        localStorage.setItem('darkMode', 'enabled');
    } else {
        localStorage.setItem('darkMode', 'disabled');
    }
});
