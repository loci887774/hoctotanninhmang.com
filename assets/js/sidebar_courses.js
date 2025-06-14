document.addEventListener('DOMContentLoaded', function() {
    const sidebar = document.getElementById('courseSidebar');
    const toggleBtn = document.getElementById('sidebarToggleBtn');
    const toggleIcon = toggleBtn.querySelector('.toggle-icon');

    toggleBtn.addEventListener('click', function() {
        sidebar.classList.toggle('collapsed'); // Chuyển đổi trạng thái collapsed

        // Cập nhật icon mũi tên
        if (toggleIcon.classList.contains('fa-chevron-right')) {
            toggleIcon.classList.remove('fa-chevron-right');
            toggleIcon.classList.add('fa-chevron-left');
        } else {
            toggleIcon.classList.remove('fa-chevron-left');
            toggleIcon.classList.add('fa-chevron-right');
        }

        // Cập nhật vị trí của nút toggle dựa trên trạng thái sidebar
        if (sidebar.classList.contains('collapsed')) {
            // Sidebar đang đóng lại, nút di chuyển về vị trí 30px
            toggleBtn.style.left = '30px';
        } else {
            // Sidebar đang mở ra, nút di chuyển về vị trí 250px
            toggleBtn.style.left = '30%';
        }
    });

    // Khởi tạo vị trí và icon ban đầu (nếu cần)
    // Nếu sidebar mặc định đã là collapsed (có class 'collapsed' trong HTML),
    // thì CSS đã đảm bảo left: 30px và icon là fa-chevron-right.
    // Nếu bạn muốn sidebar ban đầu là mở (không có class 'collapsed' trong HTML),
    // thì bạn sẽ cần thêm dòng này để thiết lập vị trí ban đầu cho nút:
    // if (!sidebar.classList.contains('collapsed')) {
    //     toggleBtn.style.left = '250px';
    //     toggleIcon.classList.remove('fa-chevron-right');
    //     toggleIcon.classList.add('fa-chevron-left');
    // }
});