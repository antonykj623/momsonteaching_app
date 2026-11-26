class ApiConstants {
  // Update with your production PHP/MySQL backend URL
  static const String baseUrl = 'https://api.momsonteaching.com/v1';
  static const String externalPaymentUrl = 'https://pay.momsonteaching.com/checkout';
  
  static const String loginEndpoint = '$baseUrl/auth/login.php';
  static const String sessionsEndpoint = '$baseUrl/sessions/list.php';
  static const String attendanceEndpoint = '$baseUrl/attendance/mark.php';
  static const String postClassUpdateEndpoint = '$baseUrl/sessions/post_update.php';
  static const String homeworkUploadEndpoint = '$baseUrl/homework/submit.php';
}
