DROP DATABASE IF EXISTS anninhmang;
CREATE DATABASE anninhmang;
-- Bước 2: Chọn cơ sở dữ liệu để sử dụng
-- Lệnh này sẽ chuyển sang sử dụng cơ sở dữ liệu 'anninhmang' vừa tạo.
USE anninhmang;

CREATE TABLE KHOA_HOC (
	kh_id INT PRIMARY KEY AUTO_INCREMENT, 
	kh_name VARCHAR(255) NOT NULL,        
	kh_soluong_baihoc INT,                
	kh_dokho VARCHAR(50),                 
	kh_url VARCHAR(255),                  
	kh_mota TEXT,
	hkh_id INT,
	FOREIGN KEY (hkh_id) REFERENCES hinh_khoa_hoc(hkh_id)  	                   
);



CREATE TABLE hinh_khoa_hoc (
	hkh_id INT AUTO_INCREMENT PRIMARY KEY,
	hkh_ten VARCHAR(255) NOT NULL
);

INSERT INTO hinh_khoa_hoc(hkh_ten) VALUES ('firewall.jpg');
INSERT INTO hinh_khoa_hoc(hkh_ten) VALUES ('malware.jpg');
INSERT INTO hinh_khoa_hoc(hkh_ten) VALUES ('attt_canhan.jpg');
INSERT INTO hinh_khoa_hoc(hkh_ten) VALUES ('ktttm.jpg');
INSERT INTO hinh_khoa_hoc(hkh_ten) VALUES ('OWASP.jpg');
INSERT INTO hinh_khoa_hoc(hkh_ten) VALUES ('cf.jpg');


INSERT INTO KHOA_HOC (kh_name, kh_soluong_baihoc, kh_dokho, kh_mota, hkh_id) VALUES
('Tường lửa nâng cao', 5, 'Khó', 'Khóa học chuyên sâu về cấu hình và quản lý tường lửa nâng cao.', 1),
('Phân tích mã độc', 4, 'Trung bình', 'Tìm hiểu các kỹ thuật phân tích và gỡ lỗi mã độc.', 2),
('An toàn thông tin cá nhân', 5, 'Dễ', 'Hướng dẫn bảo vệ thông tin cá nhân trên môi trường số.', 3),
('Kỹ thuật tấn công mạng cơ bản', 4, 'Khó', 'Giới thiệu các kỹ thuật tấn công mạng phổ biến và cách phòng tránh.', 4),
('Bảo mật Website với OWASP Top 10', 5, 'Trung bình', 'Học cách bảo vệ website khỏi các lỗ hổng bảo mật theo OWASP Top 10.', 5),
('Pháp y máy tính và Điều tra số', 5, 'Khó', 'Học cách thu thập, bảo quản và phân tích bằng chứng số để điều tra các vụ án mạng hoặc sự cố an ninh.', 6);



-- Tạo bảng USER (Users)=============================================================================================
CREATE TABLE USER (
	user_id INT PRIMARY KEY AUTO_INCREMENT,     
	username VARCHAR(100) UNIQUE NOT NULL,      
	email VARCHAR(255) UNIQUE NOT NULL,         
	password_hash VARCHAR(255) NOT NULL,        
	full_name VARCHAR(255)                                          
);


INSERT IGNORE INTO USER (user_id, username, email, password_hash, full_name) VALUES 
(1, 'kitty', 'kitty.dt@example.com', '$10$CbqfCkeo.PhibOzDwA8Mh.tNYpZWB4LagjycAQTHXPVOGc6.hj0nK', 'Kitty Đáng Thương'),
(2, 'HoaHongDen', 'hoahongden.dk@example.com', '$2y$10$65KTR/LT8Iie6PvtUPGa2ORpUJuw6xDsKSDfXJ.FEwMff0laOey2S', 'Kitty Đáng Khinh'),
(3, 'user', 'user.dk@example.com', '$2y$10$.i1wtI8lyG7wM.aFZF54VemQELKQSnpu2LWVb4tRPglog8pugnh.K', 'user')
(4, 'labubu', 'labubu.dk@example.com', '$2y$10$OV6L4/nGZhxQkskSiRa4G.ME8ByLU9whEs8Mjst8A3128nY9IR1pq', 'labubu')
(5, 'chicken', 'chicken.dk@example.com', '$2y$10$nERoTae2N4u5/5NLeBu.Luhx9Dtghmo2Td9oPQ1DTpmGc21Zo2WM.', 'chicken');


-- Tạo lại bảng BAI_HOC=============================================================================================

CREATE TABLE BAI_HOC (
	bh_id INT PRIMARY KEY AUTO_INCREMENT,   
	kh_id INT NOT NULL,                     
	bh_tieude VARCHAR(255) NOT NULL,        
	bh_noidung TEXT,                        
	bh_thutu INT,                           
	bh_ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP, 
	bh_cap_nhat DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
	bh_diem INT,                            
	FOREIGN KEY (kh_id) REFERENCES KHOA_HOC(kh_id) 
);


INSERT INTO bai_hoc (kh_id, bh_tieude, bh_noidung, bh_thutu, bh_ngay_tao, bh_cap_nhat, bh_diem) VALUES
(1, 'Bài 1: Tổng quan về Tường lửa và Vai trò', 'Tường lửa (Firewall) là một hệ thống bảo mật mạng giám sát và kiểm soát lưu lượng mạng đến và đi dựa trên các quy tắc bảo mật được xác định trước. Trong bài học này, chúng ta sẽ đi sâu vào định nghĩa cơ bản của tường lửa, lịch sử phát triển của nó, và vai trò không thể thiếu của tường lửa trong việc bảo vệ cả mạng cá nhân và doanh nghiệp. Bạn sẽ hiểu tường lửa hoạt động như một "hàng rào" kỹ thuật số, lọc bỏ các gói dữ liệu độc hại hoặc không mong muốn. Chúng ta cũng sẽ phân loại các loại tường lửa khác nhau như tường lửa phần mềm, tường lửa phần cứng, tường lửa trạng thái (stateful firewall) và tường lửa thế hệ mới (Next-Generation Firewall - NGFW), từ đó giúp bạn có cái nhìn toàn diện về cách thức chúng bảo vệ hệ thống khỏi các mối đe dọa từ bên ngoài.', 1, '2024-06-12 09:00:00', '2024-06-12 09:00:00', 20),
(1, 'Bài 2: Tường lửa trạng thái (Stateful Firewall)', 'Tường lửa trạng thái là một trong những loại tường lửa phổ biến và hiệu quả nhất hiện nay. Không giống như các tường lửa lọc gói đơn giản, tường lửa trạng thái có khả năng theo dõi trạng thái của các kết nối mạng đang hoạt động. Điều này có nghĩa là nó không chỉ kiểm tra các gói tin riêng lẻ mà còn xem xét ngữ cảnh của chúng trong một luồng giao tiếp. Trong bài học này, chúng ta sẽ tìm hiểu cơ chế hoạt động của bảng trạng thái (state table) mà tường lửa sử dụng để lưu trữ thông tin về các kết nối đã thiết lập. Bạn sẽ hiểu cách tường lửa trạng thái có thể cho phép các gói tin hợp lệ đi qua và chặn các gói tin không liên quan hoặc độc hại dựa trên trạng thái hiện tại của phiên giao tiếp. Đây là một khái niệm cốt lõi để xây dựng các chính sách bảo mật mạng hiệu quả và linh hoạt.', 2, '2024-06-12 10:30:00', '2024-06-12 10:30:00', 20),
(1, 'Bài 3: Tường lửa thế hệ mới (NGFW)', 'Tường lửa thế hệ mới (Next-Generation Firewall - NGFW) là một bước tiến vượt bậc so với các loại tường lửa truyền thống, tích hợp nhiều tính năng bảo mật tiên tiến vào một giải pháp duy nhất. Bài học này sẽ giới thiệu cho bạn các khả năng chính của NGFW, bao gồm khả năng nhận diện ứng dụng (Application Awareness), hệ thống ngăn chặn xâm nhập (Intrusion Prevention System - IPS) tích hợp, và khả năng kiểm tra lưu lượng mã hóa SSL/TLS. Chúng ta sẽ phân tích cách NGFW không chỉ dựa vào cổng và giao thức mà còn hiểu được ứng dụng nào đang truyền tải dữ liệu, từ đó có thể áp dụng các chính sách chi tiết hơn. Bạn cũng sẽ tìm hiểu về cách NGFW tích hợp thông tin về mối đe dọa (threat intelligence) để đưa ra quyết định chặn chính xác hơn, mang lại khả năng bảo vệ toàn diện và sâu rộng hơn cho hệ thống mạng.', 3, '2024-06-12 13:00:00', '2024-06-12 13:00:00', 20),
(1, 'Bài 4: Triển khai và Cấu hình Tường lửa', 'Bài học này tập trung vào khía cạnh thực hành của việc triển khai và cấu hình tường lửa. Chúng ta sẽ thảo luận về các mô hình triển khai tường lửa phổ biến như kiến trúc "mạng phi quân sự" (DMZ - Demilitarized Zone), nơi các máy chủ công cộng như máy chủ web hoặc email được đặt để cách ly khỏi mạng nội bộ. Bạn sẽ học cách xác định các yêu cầu về chính sách bảo mật và chuyển chúng thành các quy tắc tường lửa cụ thể. Chúng ta sẽ xem xét các ví dụ về cách thiết lập quy tắc cho phép hoặc từ chối lưu lượng dựa trên địa chỉ IP nguồn/đích, cổng, và giao thức. Bài học cũng sẽ đề cập đến các thách thức thường gặp trong cấu hình tường lửa và cách khắc phục để đảm bảo hệ thống của bạn được bảo vệ một cách hiệu quả và đúng đắn.', 4, '2024-06-12 14:30:00', '2024-06-12 14:30:00', 20),
(1, 'Bài 5: Quản lý và Giám sát Tường lửa', 'Việc triển khai tường lửa chỉ là bước đầu; việc quản lý và giám sát liên tục là chìa khóa để duy trì một hệ thống bảo mật hiệu quả. Trong bài học này, chúng ta sẽ tìm hiểu về các công cụ và kỹ thuật để giám sát hoạt động của tường lửa, bao gồm việc phân tích nhật ký (logs) để phát hiện các mối đe dọa và hoạt động bất thường. Bạn sẽ học cách diễn giải các cảnh báo từ tường lửa và thực hiện các hành động cần thiết để ứng phó. Bài học cũng sẽ đề cập đến việc duy trì và cập nhật các quy tắc tường lửa theo thời gian để phản ánh những thay đổi trong môi trường mạng và các mối đe dọa mới. Nắm vững các kỹ năng quản lý này sẽ giúp bạn đảm bảo tường lửa của mình luôn hoạt động tối ưu và cung cấp khả năng bảo vệ liên tục cho hệ thống.', 5, '2024-06-12 16:00:00', '2024-06-12 16:00:00', 20);

-- Dữ liệu cho Khóa học 2 (kh_id = 2): Phân tích mã độc
-- Có 4 bài học, mỗi bài 25 điểm
INSERT INTO bai_hoc (kh_id, bh_tieude, bh_noidung, bh_thutu, bh_ngay_tao, bh_cap_nhat, bh_diem) VALUES
(2, 'Bài 1: Giới thiệu về Mã độc và Phân loại', 'Mã độc (Malware) là bất kỳ phần mềm nào được tạo ra với mục đích gây hại cho hệ thống máy tính, mạng hoặc người dùng. Trong bài học này, chúng ta sẽ bắt đầu bằng cách định nghĩa mã độc và tầm quan trọng của việc phân tích nó trong lĩnh vực an ninh mạng. Bạn sẽ tìm hiểu về các loại mã độc phổ biến nhất, bao gồm Virus (lây nhiễm vào các tệp tin), Worm (tự nhân bản qua mạng), Trojan Horse (ngụy trang thành phần mềm hợp pháp), Ransomware (mã hóa dữ liệu và đòi tiền chuộc), Spyware (thu thập thông tin người dùng), và Adware (hiển thị quảng cáo không mong muốn). Nắm vững các định nghĩa và phân loại này là nền tảng để bạn có thể hiểu sâu hơn về cách thức hoạt động và cách phân tích các mối đe dọa phức tạp này.', 1, '2024-06-12 09:00:00', '2024-06-12 09:00:00', 25),
(2, 'Bài 2: Phân tích tĩnh Mã độc', 'Phân tích tĩnh mã độc là quá trình kiểm tra mã nhị phân của mã độc mà không thực sự chạy nó. Phương pháp này giúp các nhà phân tích hiểu cấu trúc, chức năng và các dấu hiệu nhận dạng của mã độc mà không gặp rủi ro lây nhiễm hệ thống. Trong bài học này, chúng ta sẽ đi sâu vào các kỹ thuật phân tích tĩnh, bao gồm việc sử dụng các công cụ như disassembler (như IDA Pro, Ghidra) để dịch ngược mã máy thành mã hợp ngữ, và string extraction để tìm kiếm các chuỗi văn bản hữu ích (ví dụ: URL máy chủ C2, tên file, thông báo lỗi). Chúng ta cũng sẽ thảo luận về việc phân tích header của file (PE header trên Windows) để thu thập thông tin về cấu trúc và các thư viện mà mã độc sử dụng. Đây là bước đầu tiên quan trọng trong quá trình phân tích mã độc chuyên sâu.', 2, '2024-06-12 10:30:00', '2024-06-12 10:30:00', 25),
(2, 'Bài 3: Phân tích động Mã độc', 'Phân tích động mã độc là quá trình quan sát hành vi của mã độc khi nó đang chạy trong một môi trường được kiểm soát và cô lập (sandbox). Phương pháp này bổ sung cho phân tích tĩnh bằng cách cung cấp thông tin về cách mã độc tương tác với hệ thống, mạng và các tiến trình khác. Trong bài học này, chúng ta sẽ tìm hiểu cách thiết lập một môi trường sandbox an toàn để thực thi mã độc. Bạn sẽ được hướng dẫn sử dụng các công cụ giám sát hệ thống (như Process Monitor, Wireshark, Regshot) để theo dõi các thay đổi về file, registry, kết nối mạng và các tiến trình mà mã độc tạo ra. Bài học cũng sẽ đề cập đến các kỹ thuật tránh phát hiện (anti-analysis techniques) mà mã độc sử dụng và cách vượt qua chúng để thu thập thông tin cần thiết về hành vi độc hại của nó.', 3, '2024-06-12 13:00:00', '2024-06-12 13:00:00', 25),
(2, 'Bài 4: Các công cụ và Môi trường Phân tích', 'Để thực hiện phân tích mã độc hiệu quả, việc lựa chọn và sử dụng đúng công cụ và môi trường là rất quan trọng. Bài học này sẽ giới thiệu cho bạn một số công cụ phổ biến và môi trường lab cần thiết cho cả phân tích tĩnh và động. Chúng ta sẽ khám phá các công cụ như IDA Pro (disassembler), Ghidra (disassembler và decompiler), Wireshark (phân tích gói tin mạng), Process Monitor (giám sát hoạt động hệ thống), Cuckoo Sandbox (hệ thống phân tích mã độc tự động), và các công cụ hex editor. Bạn cũng sẽ được hướng dẫn cách thiết lập một môi trường lab an toàn bằng cách sử dụng máy ảo (VMware, VirtualBox) để cô lập mã độc, đảm bảo rằng quá trình phân tích không gây nguy hiểm cho hệ thống chính của bạn. Nắm vững việc sử dụng các công cụ này sẽ giúp bạn thực hiện các phân tích mã độc một cách chuyên nghiệp và hiệu quả.', 4, '2024-06-12 14:30:00', '2024-06-12 14:30:00', 25);

-- Dữ liệu cho Khóa học 3 (kh_id = 3): An toàn thông tin cá nhân
-- Có 5 bài học, mỗi bài 20 điểm
INSERT INTO bai_hoc (kh_id, bh_tieude, bh_noidung, bh_thutu, bh_ngay_tao, bh_cap_nhat, bh_diem) VALUES
(3, 'Bài 1: Bảo vệ danh tính và thông tin cá nhân', 'Danh tính số của bạn là một tài sản quý giá. Bài học này sẽ giúp bạn hiểu rõ các mối đe dọa đối với danh tính cá nhân trực tuyến, bao gồm lừa đảo giả mạo (identity theft), giả mạo thông tin cá nhân (impersonation), và các hình thức thu thập dữ liệu trái phép. Chúng ta sẽ đi sâu vào các loại thông tin cá nhân cần được bảo vệ (ví dụ: số CMND/CCCD, thông tin ngân hàng, ngày sinh, địa chỉ nhà) và các rủi ro liên quan đến việc rò rỉ chúng. Bạn sẽ học các chiến lược để giảm thiểu việc tiếp xúc thông tin cá nhân, như cẩn trọng khi chia sẻ trên mạng xã hội, kiểm tra chính sách bảo mật của các ứng dụng và dịch vụ, và sử dụng thông tin tối thiểu khi đăng ký tài khoản mới. Mục tiêu là giúp bạn xây dựng một thói quen bảo mật chủ động để bảo vệ danh tính số của mình một cách toàn diện.', 1, '2024-06-12 09:00:00', '2024-06-12 09:00:00', 20),
(3, 'Bài 2: Quản lý mật khẩu và Xác thực đa yếu tố', 'Mật khẩu yếu hoặc được tái sử dụng là cánh cửa chính cho tin tặc xâm nhập vào tài khoản của bạn. Bài học này sẽ là kim chỉ nam giúp bạn tạo và quản lý mật khẩu một cách an toàn nhất. Chúng ta sẽ khám phá các tiêu chí cho một mật khẩu mạnh: độ dài, sự kết hợp của chữ hoa, chữ thường, số và ký tự đặc biệt, cũng như sự độc đáo (không dùng lại mật khẩu). Bạn sẽ được giới thiệu về các trình quản lý mật khẩu (password manager) như Bitwarden, LastPass, KeePass – những công cụ tuyệt vời giúp bạn tạo, lưu trữ và tự động điền các mật khẩu phức tạp mà không cần phải ghi nhớ. Đặc biệt, bài học sẽ nhấn mạnh tầm quan trọng của xác thực đa yếu tố (MFA/2FA), một lớp bảo mật bổ sung yêu cầu bạn cung cấp thêm một yếu tố xác minh (ví dụ: mã OTP từ điện thoại) ngoài mật khẩu, giúp bảo vệ tài khoản ngay cả khi mật khẩu bị lộ.', 2, '2024-06-12 10:30:00', '2024-06-12 10:30:00', 20),
(3, 'Bài 3: An toàn khi sử dụng Wi-Fi công cộng và VPN', 'Wi-Fi công cộng tiện lợi nhưng tiềm ẩn rất nhiều rủi ro bảo mật. Bài học này sẽ cảnh báo bạn về các mối nguy hiểm khi kết nối với mạng Wi-Fi không an toàn, bao gồm việc tin tặc có thể dễ dàng chặn hoặc đánh cắp dữ liệu của bạn thông qua các cuộc tấn công "man-in-the-middle". Chúng ta sẽ đi sâu vào cách nhận diện các mạng Wi-Fi giả mạo và các mẹo để giảm thiểu rủi ro khi buộc phải sử dụng chúng. Giải pháp hàng đầu để bảo vệ dữ liệu trên mạng công cộng là sử dụng Mạng riêng ảo (VPN - Virtual Private Network). Bài học sẽ giải thích VPN là gì, cách nó hoạt động để mã hóa lưu lượng truy cập và ẩn địa chỉ IP của bạn, tạo ra một kênh an toàn qua internet không đáng tin cậy. Bạn sẽ học cách chọn một dịch vụ VPN uy tín và khi nào nên sử dụng nó để bảo vệ thông tin cá nhân của mình.', 3, '2024-06-12 13:00:00', '2024-06-12 13:00:00', 20),
(3, 'Bài 4: Nhận diện Lừa đảo trực tuyến (Phishing, Scam)', 'Lừa đảo trực tuyến là một trong những mối đe dọa dai dẳng nhất đối với an toàn thông tin cá nhân. Bài học này sẽ trang bị cho bạn kỹ năng nhận diện và tránh các hình thức lừa đảo phổ biến, đặc biệt là Phishing (lừa đảo giả mạo). Chúng ta sẽ phân tích các dấu hiệu nhận biết của email lừa đảo (từ địa chỉ email giả mạo, lỗi chính tả, lời kêu gọi khẩn cấp) và các website giả mạo (URL đáng ngờ, giao diện kém chuyên nghiệp). Bài học cũng sẽ đề cập đến các loại hình lừa đảo khác như lừa đảo qua tin nhắn SMS (Smishing), lừa đảo qua điện thoại (Vishing), và các chiêu trò lừa đảo tình cảm (romance scams) hay đầu tư siêu lợi nhuận. Mục tiêu là giúp bạn phát triển một "con mắt cảnh giác" để không rơi vào bẫy của những kẻ lừa đảo tinh vi.', 4, '2024-06-12 14:30:00', '2024-06-12 14:30:00', 20),
(3, 'Bài 5: An toàn cho thiết bị di động và IoT', 'Thiết bị di động (smartphone, tablet) và các thiết bị IoT (Internet of Things) như nhà thông minh, thiết bị đeo tay đã trở thành một phần không thể thiếu trong cuộc sống, nhưng chúng cũng là mục tiêu mới của các mối đe dọa bảo mật. Bài học này sẽ hướng dẫn bạn các biện pháp bảo mật cho các thiết bị này. Chúng ta sẽ thảo luận về tầm quan trọng của việc cập nhật hệ điều hành và ứng dụng thường xuyên, chỉ cài đặt ứng dụng từ các nguồn đáng tin cậy (chợ ứng dụng chính thức), và quản lý quyền truy cập của ứng dụng. Bài học cũng sẽ đề cập đến việc bảo mật các thiết bị IoT bằng cách thay đổi mật khẩu mặc định, vô hiệu hóa các tính năng không cần thiết, và cập nhật firmware. Nắm vững các nguyên tắc này sẽ giúp bạn bảo vệ toàn bộ hệ sinh thái thiết bị thông minh của mình khỏi các cuộc tấn công.', 5, '2024-06-12 16:00:00', '2024-06-12 16:00:00', 20);

-- Dữ liệu cho Khóa học 4 (kh_id = 4): Kỹ thuật tấn công mạng cơ bản
-- Có 4 bài học, mỗi bài 25 điểm
INSERT INTO bai_hoc (kh_id, bh_tieude, bh_noidung, bh_thutu, bh_ngay_tao, bh_cap_nhat, bh_diem) VALUES
(4, 'Bài 1: Giới thiệu về Tin tặc và Các giai đoạn tấn công', 'Bài học này sẽ cung cấp cái nhìn tổng quan về thế giới của các cuộc tấn công mạng, bắt đầu bằng việc phân biệt giữa các loại tin tặc (hacker): từ "mũ trắng" (ethical hackers) cho đến "mũ đen" (malicious hackers). Chúng ta sẽ đi sâu vào mô hình "kill chain" – một khuôn khổ mô tả các giai đoạn điển hình của một cuộc tấn công mạng, bao gồm: trinh sát (reconnaissance), vũ khí hóa (weaponization), phân phối (delivery), khai thác (exploitation), cài đặt (installation), điều khiển và kiểm soát (command and control), và hành động trên mục tiêu (actions on objectives). Hiểu rõ các giai đoạn này sẽ giúp bạn không chỉ nắm bắt cách kẻ tấn công hoạt động mà còn nhận diện các điểm mà bạn có thể can thiệp để ngăn chặn cuộc tấn công.', 1, '2024-06-12 09:00:00', '2024-06-12 09:00:00', 25),
(4, 'Bài 2: Tấn công từ chối dịch vụ (DDoS)', 'Tấn công từ chối dịch vụ (DDoS) là một loại tấn công mạng nhằm làm cho một dịch vụ trực tuyến không khả dụng bằng cách làm tràn ngập lưu lượng truy cập từ nhiều nguồn khác nhau. Trong bài học này, chúng ta sẽ khám phá các phương pháp tấn công DDoS phổ biến, bao gồm tấn công dựa trên thể tích (volume-based attacks) như UDP Flood, ICMP Flood; tấn công dựa trên giao thức (protocol attacks) như SYN Flood; và tấn công lớp ứng dụng (application-layer attacks) như HTTP Flood. Bạn sẽ hiểu cách các cuộc tấn công này khai thác các lỗ hổng trong băng thông, tài nguyên máy chủ hoặc ứng dụng để làm quá tải mục tiêu. Bài học cũng sẽ đề cập đến các dấu hiệu nhận biết một cuộc tấn công DDoS và các biện pháp phòng thủ cơ bản để giảm thiểu tác động của chúng.', 2, '2024-06-12 10:30:00', '2024-06-12 10:30:00', 25),
(4, 'Bài 3: SQL Injection và Cross-Site Scripting (XSS)', 'SQL Injection và Cross-Site Scripting (XSS) là hai trong số những lỗ hổng bảo mật web phổ biến và nguy hiểm nhất mà tin tặc thường khai thác. Trong bài học này, chúng ta sẽ tìm hiểu cách thức hoạt động của SQL Injection, nơi kẻ tấn công chèn các câu lệnh SQL độc hại vào các trường nhập liệu để thao túng hoặc truy xuất dữ liệu từ cơ sở dữ liệu. Bạn sẽ được xem các ví dụ thực tế về cách SQL Injection có thể bị thực hiện và cách phòng tránh nó bằng cách sử dụng các câu lệnh đã chuẩn bị (prepared statements) hoặc ORM. Tiếp theo, bài học sẽ đi sâu vào XSS, nơi kẻ tấn công chèn mã độc JavaScript vào các trang web xem được bởi người dùng khác. Chúng ta sẽ phân biệt giữa XSS phản xạ, XSS lưu trữ và XSS DOM-based, cùng với các biện pháp bảo vệ như mã hóa đầu ra và sử dụng Content Security Policy (CSP).', 3, '2024-06-12 13:00:00', '2024-06-12 13:00:00', 25),
(4, 'Bài 4: Tấn công Brute-Force và Dictionary', 'Tấn công Brute-Force và Dictionary là những kỹ thuật phổ biến được sử dụng để đoán mật khẩu hoặc khóa mã hóa bằng cách thử mọi tổ hợp hoặc dựa trên danh sách các từ có sẵn. Trong bài học này, chúng ta sẽ phân biệt hai loại tấn công này: Brute-Force thử tất cả các khả năng có thể, trong khi Dictionary Attack sử dụng một danh sách các mật khẩu phổ biến hoặc từ điển. Bạn sẽ hiểu cách kẻ tấn công sử dụng các công cụ tự động để thực hiện hàng ngàn, thậm chí hàng triệu lần thử trong thời gian ngắn. Bài học cũng sẽ thảo luận về các biện pháp phòng chống hiệu quả, bao gồm việc sử dụng mật khẩu mạnh và dài, áp dụng xác thực đa yếu tố (MFA), giới hạn số lần đăng nhập thất bại (rate limiting), và triển khai CAPTCHA để ngăn chặn các nỗ lực tự động.', 4, '2024-06-12 14:30:00', '2024-06-12 14:30:00', 25);

-- Dữ liệu cho Khóa học 5 (kh_id = 5): Bảo mật Website với OWASP Top 10
-- Có 5 bài học, mỗi bài 20 điểm
INSERT INTO bai_hoc (kh_id, bh_tieude, bh_noidung, bh_thutu, bh_ngay_tao, bh_cap_nhat, bh_diem) VALUES
(5, 'Bài 1: Giới thiệu OWASP Top 10 và Tiêm nhiễm (Injection)', 'OWASP Top 10 là một tài liệu chuẩn hóa về các rủi ro bảo mật quan trọng nhất đối với ứng dụng web, được cập nhật định kỳ bởi Tổ chức Phi lợi nhuận về An ninh Ứng dụng Mở (OWASP). Bài học này sẽ giới thiệu tổng quan về OWASP Top 10, vai trò của nó trong việc nâng cao nhận thức và bảo mật web. Chúng ta sẽ đi sâu vào mục đầu tiên và cũng là phổ biến nhất: Tiêm nhiễm (Injection), bao gồm SQL Injection, NoSQL Injection, OS Command Injection, v.v. Bạn sẽ hiểu cách kẻ tấn công chèn dữ liệu không hợp lệ vào ứng dụng để thực thi các lệnh độc hại, thao túng cơ sở dữ liệu hoặc hệ thống. Bài học sẽ cung cấp các ví dụ và hướng dẫn cơ bản về cách ngăn chặn các cuộc tấn công tiêm nhiễm thông qua việc sử dụng prepared statements, mã hóa đầu vào và xác thực nghiêm ngặt.', 1, '2024-06-12 09:00:00', '2024-06-12 09:00:00', 20),
(5, 'Bài 2: Lỗ hổng Xác thực bị hỏng (Broken Authentication)', 'Lỗ hổng Xác thực bị hỏng (Broken Authentication) là một vấn đề nghiêm trọng khi các chức năng liên quan đến xác thực và quản lý phiên của ứng dụng không được triển khai đúng cách, cho phép kẻ tấn công vượt qua hệ thống xác thực hoặc đánh cắp danh tính người dùng. Trong bài học này, chúng ta sẽ tìm hiểu các kịch bản phổ biến dẫn đến lỗ hổng này, bao gồm tấn công brute-force, thông tin đăng nhập mặc định yếu, quản lý phiên không an toàn (ví dụ: ID phiên dễ đoán, không hết hạn), và lộ lọt thông tin nhạy cảm trong quá trình đăng nhập. Bạn sẽ học cách thiết kế và triển khai một hệ thống xác thực mạnh mẽ, sử dụng mật khẩu an toàn, xác thực đa yếu tố (MFA), và quản lý phiên hiệu quả để bảo vệ tài khoản người dùng khỏi các cuộc tấn công.', 2, '2024-06-12 10:30:00', '2024-06-12 10:30:00', 20),
(5, 'Bài 3: Lỗ hổng Cross-Site Scripting (XSS)', 'Cross-Site Scripting (XSS) là một loại lỗ hổng bảo mật web mà kẻ tấn công có thể chèn mã kịch bản độc hại (thường là JavaScript) vào các trang web hợp pháp được xem bởi người dùng khác. Khi người dùng truy cập trang web bị nhiễm, trình duyệt của họ sẽ thực thi mã độc đó, cho phép kẻ tấn công đánh cắp cookie, chiếm quyền phiên, hoặc chuyển hướng người dùng đến các trang web lừa đảo. Trong bài học này, chúng ta sẽ phân biệt ba loại XSS chính: Reflected XSS (phản xạ), Stored XSS (lưu trữ) và DOM-based XSS. Bạn sẽ học cách các cuộc tấn công này được thực hiện và quan trọng hơn là các biện pháp phòng chống hiệu quả, bao gồm việc mã hóa đầu ra (output encoding), sử dụng Content Security Policy (CSP), và xác thực đầu vào nghiêm ngặt để ngăn chặn mã độc thực thi trong trình duyệt người dùng.', 3, '2024-06-12 13:00:00', '2024-06-12 13:00:00', 20),
(5, 'Bài 4: Thiếu kiểm soát truy cập (Broken Access Control)', 'Thiếu kiểm soát truy cập (Broken Access Control) là một lỗ hổng phổ biến xảy ra khi ứng dụng không thực thi đúng các hạn chế về quyền truy cập được cấu hình, cho phép người dùng thực hiện các hành động mà họ không có quyền. Điều này có thể dẫn đến việc người dùng bình thường truy cập vào các chức năng quản trị, xem hoặc sửa đổi dữ liệu của người dùng khác, hoặc truy cập vào các tệp tin nhạy cảm. Trong bài học này, chúng ta sẽ tìm hiểu các kịch bản phổ biến của lỗ hổng kiểm soát truy cập bị hỏng, ví dụ như thay đổi tham số URL để truy cập tài nguyên không được phép (IDOR - Insecure Direct Object References), hoặc bỏ qua kiểm tra quyền. Bạn sẽ học cách thiết kế và triển khai một hệ thống kiểm soát truy cập mạnh mẽ, dựa trên nguyên tắc "ít đặc quyền nhất" (least privilege), để đảm bảo rằng mỗi người dùng chỉ có thể truy cập vào các tài nguyên và chức năng mà họ được phép.', 4, '2024-06-12 14:30:00', '2024-06-12 14:30:00', 20),
(5, 'Bài 5: Cấu hình bảo mật sai (Security Misconfiguration)', 'Cấu hình bảo mật sai (Security Misconfiguration) là một trong những rủi ro dễ xảy ra nhất, thường là kết quả của việc cấu hình không đúng hoặc thiếu sót trong bất kỳ thành phần nào của stack ứng dụng (web server, application server, database, framework, thư viện). Bài học này sẽ khám phá các ví dụ phổ biến về cấu hình sai, bao gồm việc sử dụng cài đặt mặc định không an toàn, không vá lỗi hoặc cập nhật kịp thời, bật các tính năng không cần thiết, hoặc cấu hình sai quyền truy cập file/thư mục. Chúng ta sẽ thảo luận về tầm quan trọng của việc hardening (tăng cường bảo mật) cho từng thành phần hệ thống, việc thường xuyên kiểm tra cấu hình, và việc sử dụng các công cụ tự động để phát hiện các lỗ hổng cấu hình. Nắm vững cách tránh các sai lầm cấu hình này là chìa khóa để xây dựng một ứng dụng web an toàn và vững chắc.', 5, '2024-06-12 16:00:00', '2024-06-12 16:00:00', 20);

-- Dữ liệu cho Khóa học 6 (kh_id = 6): Pháp y máy tính
-- Có 5 bài học, mỗi bài 20 điểm
INSERT INTO bai_hoc (kh_id, bh_tieude, bh_noidung, bh_thutu, bh_ngay_tao, bh_cap_nhat, bh_diem) VALUES
(6, 'Bài 1: Giới thiệu Pháp y máy tính và Các nguyên tắc', 'Pháp y máy tính (Computer Forensics) là một nhánh của khoa học pháp y liên quan đến việc thu thập, bảo quản, phân tích và trình bày các bằng chứng kỹ thuật số theo cách pháp lý để điều tra các vụ án hình sự hoặc dân sự liên quan đến máy tính. Trong bài học này, chúng ta sẽ bắt đầu với định nghĩa cơ bản của pháp y máy tính, vai trò của nó trong kỷ nguyên số, và các nguyên tắc cốt lõi mà một nhà điều tra pháp y phải tuân thủ. Các nguyên tắc này bao gồm tính toàn vẹn của bằng chứng (không thay đổi dữ liệu gốc), tính hợp pháp (tuân thủ luật pháp), và chuỗi giám sát (chain of custody) để đảm bảo bằng chứng không bị giả mạo. Bạn sẽ hiểu tầm quan trọng của việc duy trì tính xác thực và không thể chối cãi của bằng chứng số trong quá trình điều tra.', 1, '2024-06-13 09:30:00', '2024-06-13 09:30:00', 20),
(6, 'Bài 2: Thu thập và Bảo quản Bằng chứng số', 'Việc thu thập và bảo quản bằng chứng số một cách đúng đắn là bước quan trọng nhất trong pháp y máy tính. Sai sót trong giai đoạn này có thể làm mất giá trị pháp lý của bằng chứng. Bài học này sẽ hướng dẫn bạn các kỹ thuật và công cụ để thu thập bằng chứng từ nhiều nguồn khác nhau như ổ cứng, thiết bị di động, bộ nhớ RAM và hệ thống mạng. Chúng ta sẽ tập trung vào nguyên tắc "luôn làm việc với bản sao" và cách tạo ra các bản sao bit-by-bit (forensic images) của các phương tiện lưu trữ để đảm bảo tính toàn vẹn của dữ liệu gốc. Bạn cũng sẽ học cách sử dụng các thuật toán băm (hashing algorithms) như MD5, SHA-1, SHA-256 để xác minh rằng bản sao chính xác là bản sao của dữ liệu gốc, và cách ghi lại chuỗi giám sát cho từng bằng chứng được thu thập.', 2, '2024-06-13 11:00:00', '2024-06-13 11:00:00', 20),
(6, 'Bài 3: Phân tích Dữ liệu Hệ thống tệp', 'Hệ thống tệp (File System) là nơi lưu trữ và tổ chức dữ liệu trên các thiết bị. Việc phân tích hệ thống tệp là một kỹ năng cốt lõi trong pháp y máy tính để khám phá các tệp tin đã xóa, tệp tin ẩn và các hoạt động của người dùng. Trong bài học này, chúng ta sẽ đi sâu vào cấu trúc của các hệ thống tệp phổ biến như NTFS (Windows), EXT4 (Linux), và HFS+ (macOS). Bạn sẽ học cách sử dụng các công cụ pháp y chuyên dụng để phục hồi các tệp đã bị xóa (file carving), phân tích các siêu dữ liệu (metadata) của tệp tin như thời gian tạo, sửa đổi, và truy cập. Bài học cũng sẽ đề cập đến cách xác định các phân vùng ẩn, các vùng không gian trống (unallocated space) có thể chứa bằng chứng quan trọng, và các kỹ thuật để trích xuất thông tin hữu ích từ cấu trúc hệ thống tệp.', 3, '2024-06-13 13:30:00', '2024-06-13 13:30:00', 20),
(6, 'Bài 4: Phân tích Dữ liệu Ứng dụng và Mạng', 'Ngoài dữ liệu hệ thống tệp, các ứng dụng và hoạt động mạng cũng là nguồn bằng chứng phong phú. Bài học này sẽ tập trung vào việc phân tích các dữ liệu này. Chúng ta sẽ tìm hiểu cách trích xuất và phân tích lịch sử trình duyệt web, email, tin nhắn trò chuyện, và các ứng dụng mạng xã hội để tái tạo lại hoạt động của người dùng. Bạn cũng sẽ học cách phân tích nhật ký (logs) từ hệ điều hành, máy chủ và thiết bị mạng để phát hiện các hoạt động bất thường, truy cập trái phép hoặc dấu vết của cuộc tấn công. Bài học cũng sẽ giới thiệu các công cụ phân tích gói tin mạng (như Wireshark) để kiểm tra lưu lượng mạng đã ghi lại, giúp xác định các kết nối độc hại hoặc hành vi truyền dữ liệu đáng ngờ.', 4, '2024-06-13 15:00:00', '2024-06-13 15:00:00', 20),
(6, 'Bài 5: Báo cáo Pháp y và Trình bày Bằng chứng', 'Bước cuối cùng và quan trọng trong pháp y máy tính là việc tạo báo cáo pháp y và trình bày các bằng chứng đã thu thập được một cách rõ ràng, thuyết phục và có giá trị pháp lý. Bài học này sẽ hướng dẫn bạn cách viết một báo cáo pháp y chuyên nghiệp, bao gồm các phần như mục tiêu điều tra, phương pháp luận, các phát hiện chi tiết, và kết luận. Chúng ta sẽ thảo luận về tầm quan trọng của việc sử dụng ngôn ngữ rõ ràng, chính xác, và tránh các thuật ngữ kỹ thuật phức tạp không cần thiết. Bạn cũng sẽ học cách chuẩn bị để trình bày bằng chứng trước tòa án hoặc các cơ quan có thẩm quyền, bao gồm việc giải thích các kỹ thuật phân tích và đảm bảo tính toàn vẹn của bằng chứng đã thu thập. Đây là kỹ năng then chốt để chuyển đổi các dữ liệu kỹ thuật thành thông tin có giá trị pháp lý.', 5, '2024-06-13 16:30:00', '2024-06-13 16:30:00', 20);



-- Tạo bảng FORUM_POSTS============================================================================================================
CREATE TABLE FORUM_POSTS (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,                     
    post_title VARCHAR(255) NOT NULL,
    post_short_desc VARCHAR(500),             
    post_content TEXT,
    post_created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    post_updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USER(user_id) 
);


-- Chèn dữ liệu mẫu vào bảng FORUM_POSTS với post_short_desc
INSERT INTO FORUM_POSTS (user_id, post_title, post_short_desc, post_content) VALUES
(1, 'Làm thế nào để có thể cài đặt Java trên VS code',
 'Thắc mắc về cách cài đặt Java trên VS Code và lỗi báo khi cài đặt trên MSI 15.',
 'Hello các anh chị, Kitty thắc mắc làm thế nào để tải VS Code trên máy tính laptop ạ? Em dùng MSI model 15 nhưng cài thì bị báo lỗi?'),
 
(5 , 'Cách bảo mật tài khoản mạng xã hội cá nhân',
 'Mọi người có lời khuyên gì không ạ?',
 'Chào các bác, bạn em vừa bị bay acc fb, bản thân học an toàn thông tin nhưng em không lấy acc lại được cho bạn nên nhục quá nhờ các bác khai sáng hộ em ạ. Em cảm ơn ạ!'),
 
(2 , 'So sánh Kali Linux và Parrot OS cho pentesting',
 'Nên dùng hệ điều hành nào cho hiệu quả?',
 'Chào mọi người, em đang học năm 3 và đang có định hướng học pentester, mọi người cho em xin ý kiến về 2 hệ điều hành này với');



-- Tạo lại bảng BINH_LUAN==========================================================================================================================
CREATE TABLE binh_luan (
    bl_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT NOT NULL,                      -- ID bài đăng mà bình luận thuộc về
    user_id INT NOT NULL,                      -- ID người dùng đã tạo bình luận
    bl_noidung TEXT NOT NULL,
    bl_ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    bl_cap_nhat DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES FORUM_POSTS(post_id),
    FOREIGN KEY (user_id) REFERENCES USER(user_id)         
);


INSERT INTO BINH_LUAN (post_id, user_id, bl_noidung) VALUES
(1 , 2, 'Chat GPT đi em =)))'),
(1 , 4, 'ké với ạ !'),
(1, 5, 'Em chụp ảnh báo lỗi cụ thể qua anh nhé');
