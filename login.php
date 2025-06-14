<?php session_start();
    $error_message = '';
    if(isset($_POST["btn-login-submit"])) { // Kiểm tra xem nút submit có được nhấn không
            // Lấy dữ liệu ngay sau khi form được submit
            // Để tránh lỗi "Undefined index" nếu người dùng truy cập trực tiếp
            $username = htmlspecialchars(trim($_POST['username'] ?? ''));
            $password = htmlspecialchars(trim($_POST['password'] ?? ''));

            if(empty($username) || empty($password)) {
                $error_message = "Vui lòng nhập đầy đủ thông tin!";
            } else {
                // Bao gồm file kết nối DB ngay trước khi sử dụng $conn
                include_once __DIR__ . "/dbconnect.php"; 

                // Cần kiểm tra kết nối DB có thành công không
                if ($conn->connect_error) {
                    die("Kết nối cơ sở dữ đang thất bại: " . $conn->connect_error);
                }

                $stmt = $conn->prepare("SELECT user_id, username, password_hash FROM user WHERE username = ?;"); 
                
                // Kiểm tra xem prepare có thành công không
                if ($stmt === false) {
                    // Ghi log lỗi prepare để debug (không hiển thị cho người dùng)
                    error_log("Prepare failed: (" . $conn->errno . ") " . $conn->error);
                    $error_message = "Có lỗi xảy ra, vui lòng thử lại sau.";
                } else {
                    $stmt->bind_param('s', $username);

                    // Sửa $stmt->is_execute() thành $stmt->execute()
                    // Và kiểm tra kết quả của execute
                    if ($stmt->execute()) {
                        $stmt->store_result(); // Lưu kết quả

                        if($stmt->num_rows == 1) { // Nên kiểm tra == 1, không phải != 0
                                                // Để đảm bảo username là duy nhất
                            $stmt->bind_result($db_user_id, $db_username, $db_hashed_password); // Lấy dữ liệu về
                            $stmt->fetch(); 

                            // var_dump($stmt); die;
                            // $pwd = password_hash($password, PASSWORD_DEFAULT);
                            // var_dump($pwd ); die;
                            // Kiểm tra mật khẩu thông qua mã băm
                            if(password_verify($password , $db_hashed_password)) {
                                
                                // Đăng nhập thành công, lưu thông tin vào SESSION
                                // LƯU Ý: KHÔNG ĐỂ DẤU NHÁY ĐƠN '' VÀO BIẾN SESSION
                                $_SESSION['user_id'] = $db_user_id;
                                $_SESSION['username'] = $db_username;
                                $_SESSION['logged_in'] = true; // Dùng boolean true/false thay vì chuỗi 'true'

                                header("Location: index.php"); // Chuyển hướng
                                exit(); // Thoát script sau khi chuyển hướng
                            } else {
                                // Mật khẩu không khớp
                                $error_message = "Username hoặc Password không đúng.";
                            }
                        } else {
                            // Username không tồn tại (hoặc có nhiều hơn 1, lỗi DB)
                            $error_message = "Username hoặc Password không đúng.";
                        }
                    } else {
                        // Lỗi khi thực thi câu lệnh
                        error_log("Execute failed: (" . $stmt->errno . ") " . $stmt->error);
                        $error_message = "Có lỗi xảy ra trong quá trình kiểm tra, vui lòng thử lại sau.";
                    }

                    $stmt->close(); // Luôn đóng statement
                }
                $conn->close(); // Luôn đóng kết nối DB khi hoàn tất
            } 
        }
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Học Tốt An Ninh Mạng</title>
    <?php include_once __DIR__ . '/includes/style.php'; ?>
</head>
<body class="login-page-body">
    <a href="index.php" class="btn btn-outline-light btn-back-to-forum">
            <i class="fas fa-arrow-left me-2"></i> Trở về
    </a>
    <main class="login-main d-flex justify-content-center align-items-center min-vh-100">
        <div class="login-container p-5 rounded-3 shadow">
            <h2 class="text-center mb-4 text-black fw-bold">ĐĂNG NHẬP</h2>

            <?php if($error_message != ''):?>   
                <div class="message text-center text-danger">
                    <!-- <b>hi</b> -->
                    <?= $error_message?>
                </div>
            <?php endif; ?>

            <form action="" method="POST" name="frm-login">
                <div class="mb-3">
                    <input type="text" class="form-control form-control-login" id="username" name="username" placeholder="Username" >
                </div>
                <div class="mb-4">
                    <input type="password" class="form-control form-control-login" id="password" name="password" placeholder="Password" >
                </div>
                <div class="d-grid gap-2 mb-3">
                    <button type="submit" class="btn btn-login-submit" name="btn-login-submit">Đăng nhập</button>
                </div>
            </form>
        </div>
    </main>

    <?php include_once __DIR__ . "/includes/script.php"; ?>

</body>
</html>