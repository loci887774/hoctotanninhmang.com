<?php
    session_start();
    if($_SESSION['logged_in'] != true) {
        header("Location: login.php");
    }
    include_once __DIR__ . "/dbconnect.php";

    $current_kh_id = isset($_GET['kh_id']) ? (int)$_GET['kh_id'] : 0;

    $arr_bai_hoc_trong_khoa = [];

    if ($current_kh_id > 0) {
        $stmt_bh = $conn->prepare("SELECT bh_id, bh_tieude, bh_thutu, bh_noidung, bh_diem FROM bai_hoc WHERE kh_id = ? ORDER BY bh_thutu ASC;");

        if ($stmt_bh) {
            $stmt_bh->bind_param("i", $current_kh_id);
            $stmt_bh->execute();
            $result_bh = $stmt_bh->get_result();

            while ($row_bh = $result_bh->fetch_assoc()) {
                $arr_bai_hoc_trong_khoa[] = $row_bh;
            }

            $stmt_bh->close();
        } else {
            error_log("lỗi truy vấn: .$conn->error . $conn->error");
        }
    }

    // Xác định bài học hiện tại để hiển thị nội dung và gán class active
    $current_bh_thutu_from_url = isset($_GET['bh_thutu']) ? (int)$_GET['bh_thutu'] : null;
    $current_bh_data = null; // lưu trữ dữ liệu của bài học hiện tại

    // Nếu không có bh_thutu trên URL, hoặc bh_thutu không hợp lệ, mặc định là bài đầu tiên
    if ($current_bh_thutu_from_url === null && !empty($arr_bai_hoc_trong_khoa)) {
    // Mặc định chọn bài đầu tiên trong danh sách nếu không có bh_thutu trên URL
        $current_bh_data = $arr_bai_hoc_trong_khoa[0];
    } else {
        foreach ($arr_bai_hoc_trong_khoa as $bh_item) {
            if ($bh_item['bh_thutu'] == $current_bh_thutu_from_url) {
                $current_bh_data = $bh_item;
                break;
            }

            // Nếu bh_thutu từ URL không tìm thấy, quay về bài đầu tiên (hoặc xử lý lỗi)
            if ($current_bh_data === null && !empty($arr_bai_hoc_trong_khoa)) {
                $current_bh_data = $arr_bai_hoc_trong_khoa[0];
            }
        }
    }

    // Lấy thông tin khóa học hiện tại (ví dụ để hiển thị tên khóa học)
    $current_khoa_hoc_name = "Tên Khóa Học Không Xác Định";

    if ($current_kh_id > 0) {
        $stmt_kh = $conn->prepare("SELECT kh_name FROM khoa_hoc WHERE kh_id = ?;");
        if ($stmt_kh) {
            $stmt_kh->bind_param("i", $current_kh_id);
            $stmt_kh->execute();
            $stmt_kh->bind_result($kh_name);
            if ($stmt_kh->fetch()) {
                $current_khoa_hoc_name = htmlspecialchars($kh_name);
            }
            $stmt_kh->close();
        }
    }

?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết khóa học</title>
    <?php include_once __DIR__ . '/includes/style.php'; ?>
</head>

<body>
    <main class="course-detail-main d-flex" style="background-color: var(--primary-bg-color); min-height: calc(100vh - 80px);">
        <button class="sidebar-toggle" id="sidebarToggleBtn">
            <i class="fas fa-chevron-right toggle-icon"></i>
        </button>

        <aside id="courseSidebar" class="course-sidebar collapsed">
            <div class="sidebar-content">
                <div class="completion-circle text-center mb-4">
                    <div class="circle-inner">85%</div>
                </div>

                <ul class="list-unstyled course-lesson-list">
                    <?php foreach($arr_bai_hoc_trong_khoa as $bh): ?>
                        <?php
                            // Xác định xem bài học này có phải là bài đang được xem không
                            $is_active = ($current_bh_data && $bh['bh_thutu'] == $current_bh_data['bh_thutu']) ? 'active' : '';
                        ?>

                        <li>
                            <a href="courses.php?kh_id=<?= htmlspecialchars($current_kh_id)?>&bh_thutu=<?= htmlspecialchars($bh['bh_thutu'])?>" 
                                class="lesson-item <?= $is_active ?>"> 
                                    <?= htmlspecialchars($bh['bh_tieude'])?>
                            </a>
                        </li>
                    <?php endforeach; ?>
                </ul>

                <div class="back-to-courses text-center mt-auto py-3">
                    <!-- <a href="index.php" ><i class="fa-solid fa-arrow-left"></i>Trở về</a> -->
                    <a href="index.php" class="btn btn-outline-light btn-back-to-forum">
                        <i class="fas fa-arrow-left me-2"></i> Trở về
                    </a>
                </div>
            </div>
        </aside>

        <section class="course-content flex-grow-1 p-4 container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="text-white <?= $is_active ?>"> <?= $current_khoa_hoc_name ?></h1>
                <span class=" diem-bai-hoc">Số điểm: <?= htmlspecialchars($current_bh_data['bh_diem']) ?></span>
            </div>

            <div class="ten-bai-hoc" style="background-color: var(--link-hover-color);">
                <h2 class="text-white <?= $is_active ?> text-center"> <?= $current_bh_data['bh_tieude'] ?></h2>
            </div>

            <div class="course-text-block mb-4">
                <p class="<?= $is_active ?>"><?= htmlspecialchars($current_bh_data['bh_noidung'])?></p>
            </div>
          

            <div class="progress mt-auto" style="height: 5px;">
                <div class="progress-bar bg-info" role="progressbar" style="width: 85%;" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100"></div>
            </div>
<!-- 
            <div class="d-flex justify-content-between mt-5">
                <button class="btn course-nav-btn"><i class="fas fa-chevron-left me-2"></i>Bài trước</button>
                <button class="btn  course-nav-btn">Bài tiếp <i class="fas fa-chevron-right ms-2"></i></button>
            </div> -->

            <?php
                $current_bh_index = -1;
                foreach ($arr_bai_hoc_trong_khoa as $index => $bh_item) {
                    if ($bh_item['bh_thutu'] == $current_bh_data['bh_thutu']) {
                        $current_bh_index = $index;
                        break;
                    }
                }

                $prev_bh_thutu = null;
                if ($current_bh_index > 0) {
                    $prev_bh_thutu = $arr_bai_hoc_trong_khoa[$current_bh_index - 1]['bh_thutu'];
                }

                $next_bh_thutu = null;
                if ($current_bh_index < count($arr_bai_hoc_trong_khoa) - 1) {
                    $next_bh_thutu = $arr_bai_hoc_trong_khoa[$current_bh_index + 1]['bh_thutu'];
                }
            ?>

            <div class="lesson-navigation">
                <?php if ($prev_bh_thutu !== null): ?>
                    <a href="courses.php?kh_id=<?= htmlspecialchars($current_kh_id) ?>&bh_thutu=<?= htmlspecialchars($prev_bh_thutu) ?>" class="btn btn-secondary">Bài trước</a>
                <?php endif; ?>

                <?php if ($next_bh_thutu !== null): ?>
                    <a href="courses.php?kh_id=<?= htmlspecialchars($current_kh_id) ?>&bh_thutu=<?= htmlspecialchars($next_bh_thutu) ?>" class="btn btn-primary">Bài tiếp</a>
                <?php endif; ?>
            </div>

        </section>
    </main>

    <?php include_once __DIR__ . "/includes/footer.php"; ?>
    <?php include_once __DIR__ . "/includes/script.php"; ?>

</body>
</html>