class Urls {
  static String baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registrationUrl = '$baseUrl/registration';
  static String loginUrl = '$baseUrl/login';
  static String createNewTaskUrl = '$baseUrl/createTask';
  static String newTaskUrl = '$baseUrl/listTaskByStatus/New';
  static String completedTaskUrl = '$baseUrl/listTaskByStatus/Completed';
  static String cancelledTaskUrl = '$baseUrl/listTaskByStatus/Cancelled';
  static String inProgressTaskUrl = '$baseUrl/listTaskByStatus/Progress';
  static String updateProfileUrl = '$baseUrl/profileUpdate';
  static String taskCountUrl = '$baseUrl/taskStatusCount';
  static String changeTaskStatus(String taskId, String status) =>
      '$baseUrl/updateTaskStatus/$taskId/$status';
  static String deleteTaskUrl(String taskId) => '$baseUrl/deleteTask/$taskId';
  static String recoveryEmailUrl(String email) =>
      '$baseUrl/RecoverVerifyEmail/$email';
  static String otpVerificationUrl(String email, String otp) =>
      '$baseUrl/RecoverVerifyOTP/$email/$otp';

  static String resetPasswordUrl = '$baseUrl/RecoverResetPass';
}
