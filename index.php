<?php
    session_start();
    if($_SESSION['logged_in'] != true) {
        header("Location: login.php");
    }
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khóa học An ninh mạng - Trang chủ</title>
    <?php include_once __DIR__ . '/includes/style.php'; ?>
</head>

<body>
    <!-- Trang chủ start -->
    <section class="container main-carousel">
        <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="/hoctotanninhmang.com/assets/images/sl1.jpg" class="d-block w-100" alt="Slide 1">
                </div>
                <div class="carousel-item">
                    <img src="/hoctotanninhmang.com/assets/images/sl2.jpg" class="d-block w-100" alt="Slide 2">
                </div>
                <div class="carousel-item">
                    <img src="/hoctotanninhmang.com/assets/images/sl3.jpg" class="d-block w-100" alt="Slide 3">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
            <!-- <div class="wel-com"> -->
                <h2 class="text-center mb-4 text-white mt-5">Hi '<?= $_SESSION['username']?>' </h2>   
            <!-- </div> -->
        </div>
    </section>
     <!-- Trang chủ end -->


    <!-- Trang khóa học start -->
    <section class="container my-5">
        <h2 class="text-center mb-4 text-white">Các Khóa Học Nổi Bật</h2>
        <div class="row row-cols-1 row-cols-md-3 g-4">

            <?php
                include_once __DIR__ . "/dbconnect.php";

                $sqlSELECTkhoa_hoc = "SELECT kh.kh_id, kh.kh_name, kh.kh_soluong_baihoc, kh.kh_dokho, kh.kh_mota, hkh.hkh_ten 
                                        FROM khoa_hoc kh
                                        JOIN hinh_khoa_hoc hkh 
                                        ON kh.hkh_id = hkh.hkh_id;";

                $data_sqlSELECTkhoa_hoc = mysqli_query($conn, $sqlSELECTkhoa_hoc);

                $arr_sqlSELECTkhoa_hoc = [];

                while($row =  mysqli_fetch_array($data_sqlSELECTkhoa_hoc, MYSQLI_ASSOC)) {
                    $arr_sqlSELECTkhoa_hoc[] = array(
                        'kh_id' => $row['kh_id'],
                        'kh_name' => $row['kh_name'],
                        'kh_soluong_baihoc' => $row['kh_soluong_baihoc'],
                        'kh_dokho' => $row['kh_dokho'],
                        'kh_mota' => $row['kh_mota'],
                        'hkh_ten' => $row['hkh_ten']
                    );
                };

            ?>

            <?php $src_hkh = '/hoctotanninhmang.com/assets/images/'; ?>
            <!-- Render dữ liệu khóa học -->
            <?php foreach($arr_sqlSELECTkhoa_hoc as $kh): ?>
                <!-- <?var_dump($kh); die;?> -->
                <div class="col">
                    <div class="card h-100">
                        <img src="<?= htmlspecialchars($src_hkh . $kh['hkh_ten']) ?>" class="card-img-top" alt="<?= htmlspecialchars($kh['kh_name']) ?>">
                        <div class="card-body">
                            <h5 class="card-title"> <?= $kh['kh_name'] ?> </h5>
                            <p class="card-text"> <?= $kh['kh_soluong_baihoc'] ?> bài học</p>
                            <p class="card-text">Độ khó: <?= $kh['kh_dokho'] ?></p>
                            <a href="courses.php?kh_id=<?= $kh['kh_id']?>&bh_thutu=1" class="btn btn-primary">Học ngay</a>
                        </div>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>

    </section>
    <!-- Trang khóa học end -->


    <!-- Trang diễn đàn start -->
    <section class="container py-5" id="forum-section" style="background-color: var(--primary-bg-color);">
        <div class="row">
            <?php 
            $sqlSelectBaiDang = "SELECT * FROM forum_posts;";

            $datasqlSelectBaiDang = mysqli_query($conn, $sqlSelectBaiDang);

            $arrdatasqlSelectBaiDang = [];

            while($row1 = mysqli_fetch_array($datasqlSelectBaiDang, MYSQLI_ASSOC)) {
                $arrdatasqlSelectBaiDang[] = array (
                    'post_id' => $row1['post_id'],
                    'user_id' => $row1['user_id'],
                    'post_title' => $row1['post_title'],
                    'post_short_desc' => $row1['post_short_desc'],
                    'post_content' => $row1['post_content'],
                    'post_created_at' => $row1['post_created_at'],
                    'post_updated_at' => $row1['post_updated_at']
                );
            }
            ?>

            <div class="col-11 col-md-11 forum-content">
                <h2 class="text-center">Diễn đàn An Toàn Thông Tin</h2>
                <div class="forum-posts-list">
                    <?php foreach ($arrdatasqlSelectBaiDang as $post): ?>
                        <div class="card forum-post-card mb-3">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div class="post-content">
                                    <h5 class="card-title"><?= $post['post_title']; ?></h5>
                                    <p class="card-text text-muted"><?= $post['post_short_desc']; ?></p>
                                </div>
                                <div class="post-meta text-end d-flex flex-column align-items-end">
                                    <small class="text-white-50 mb-2"><?= $post['post_created_at']; ?></small>
                                    <a href="tribune.php?post_id=<?= $post['post_id']?>" class="btn btn-sm btn-outline-info forum-detail-btn">Chi tiết</a>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>

                </div>

                <nav aria-label="Page navigation" class="mt-5">
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </section>
    <!-- Trang diễn đàn end -->

     

    <?php include_once __DIR__ . "/includes/footer.php"; ?>

    <?php include_once __DIR__ . "/includes/script.php"; ?>
</body>
</html>