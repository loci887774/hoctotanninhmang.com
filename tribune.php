<?php 
    ob_start();
    session_start();
    if($_SESSION['logged_in'] != true) {
        header("Location: login.php");
    }
    $user_id = $_SESSION['user_id'];
    // var_dump($user_id); die;
    //truy vấn cho những bình luận
    include_once __DIR__ . "/dbconnect.php";

    $post_id = $_GET['post_id'];

    $sqlBinhLuan = "SELECT
                        fp.post_id AS post_id,
                        bl.bl_id AS comment_id,
                        bl.bl_noidung,
                        u_comment.username AS commenter_username, -- Tên người bình luận
                        bl.bl_ngay_tao AS comment_created_at -- Giả sử cột thời gian tạo bình luận
                    FROM
                        forum_posts AS fp
                    LEFT JOIN
                        binh_luan AS bl ON fp.post_id = bl.post_id -- Nối để lấy các bình luận của bài đăng
                    LEFT JOIN
                        user AS u_comment ON bl.user_id = u_comment.user_id -- Nối để lấy thông tin người bình luận
                    WHERE fp.post_id = $post_id ;";

    $datasqlBinhLuan= mysqli_query($conn, $sqlBinhLuan);

    $arr_bl = [];

    while($row = mysqli_fetch_array($datasqlBinhLuan, MYSQLI_ASSOC)) {
        $arr_bl[] = array(
            'post_id' => $row['post_id'],
            'comment_id' => $row['comment_id'],
            'commenter_username' => $row['commenter_username'],
            'comment_created_at' => $row['comment_created_at'],
            'bl_noidung' => $row['bl_noidung']
        );
    };

//--------------------------------------------------------------------------------------------------------------------------------
//truy vấn chi tiết bài đăng

    $sqlBaiDangChiTiet = "SELECT * 
                        FROM forum_posts AS fp
                        JOIN user AS u 
                        ON fp.user_id = u.user_id 
                        WHERE post_id = $post_id;";

    $dataBaiDangChiTiet = mysqli_query($conn, $sqlBaiDangChiTiet);

    $post = mysqli_fetch_assoc($dataBaiDangChiTiet);
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết bài đăng - Diễn đàn</title>
    <?php include_once __DIR__ . '/includes/style.php'; ?>
</head>
<body>
    <!-- min-height: calc(100vh - 150px); -->
    <main class="forum-detail-main py-5" style="background-color: var(--primary-bg-color); "> 
        <section class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10">
                    <h1 class="forum-post-heading mb-4 text-center"><?= $post['post_title']?></h1>

                    <div class="forum-card original-post mb-5">
                        <div class="d-flex align-items-center mb-3">
                            <img src="assets/images/kitty.jpg" alt="Avatar" class="rounded-circle me-3 forum-avatar">
                            <div>
                                <h6 class="mb-0 text-white"><?= $post['username']?></h6>
                                <small class="text-white-50"><?= $post['post_created_at']?></small>
                            </div>
                        </div>
                        <p class="text-white-100">
                            <?= $post['post_content']?>
                        </p>
                    </div>
                    <h4 class="text-center text-white-20 mb-4">Trả lời</h4>
                    <?php foreach($arr_bl as $bl):?>
                        <div class="forum-comments-section">
                            <div class="forum-card comment-item mb-4">
                                <div class="d-flex align-items-center mb-3">
                                    <img src="assets/images/avt.jpg" alt="Avatar" class="rounded-circle me-3 forum-avatar">
                                    <div>
                                        <h6 class="mb-0 text-white"><?= $bl['commenter_username']?></h6>
                                        <small class="text-white-50"><?= $bl['comment_created_at']?></small>
                                    </div>
                                </div>
                                <p class="text-white"><?= $bl['bl_noidung']?></p>
                            </div>
                        </div>
                    <?php endforeach;?>
                    <form action="" method="POST" name="frm-comment">
                        <div class="forum-card comment-form mt-5">
                            <textarea class="form-control form-control-dark mb-3" name="comment-content" rows="3" placeholder="Nhập bình luận của bạn tại đây"></textarea>
                            <button type="submit" class="btn btn-primary float-end btn-submit-comment" name="btn-submit-comment">Gửi</button>
                            <div class="clearfix"></div> </div>
                        </div>
                    </form>
                    <?php 
                        if(isset($_POST['btn-submit-comment'])) {

                            $bl_noidung = $_POST['comment-content'];
                            $bl_noidung = htmlspecialchars($bl_noidung);
                            $bl_ngay_tao = date('Y-m-d H:i:s');
                            $bl_cap_nhat= date('Y-m-d H:i:s');

                            if($bl_noidung == '') {
                                $error_message = "Vui lòng nhập bình luận của bạn!";
                            } else {
                                $stmt = $conn->prepare("INSERT INTO binh_luan 
                                            (post_id, user_id, bl_noidung, bl_ngay_tao, bl_cap_nhat) 
                                            VALUES (?, ?, ?, ?, ?);");

                                $stmt->bind_param('iisss', $post_id, $user_id, $bl_noidung, $bl_ngay_tao, $bl_cap_nhat);
                                $stmt->execute();
                                ob_clean();
                                header("Location: tribune.php?post_id=" . htmlspecialchars($post_id));
                                exit();
                            }

                            $stmt->close();
                            $conn->close();
                        }
                    ?>
                </div>
            </div>

            <a href="index.php" class="btn btn-outline-light btn-back-to-forum">
                <i class="fas fa-arrow-left me-2"></i> Trở về
            </a>
        </section>



    </main>

    <?php include_once __DIR__ . "/includes/footer.php"; ?>
    <?php include_once __DIR__ . "/includes/script.php"; ?>

</body>
</html>

