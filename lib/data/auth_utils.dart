import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static String? firstName, lastName, email, mobile, profilePic, token;

  static Future<void> saveUserDate(String uFirstName, String uLastName,
      String uEmail, String uMobile, String uProfilePic, String uToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('firstName', uFirstName);
    sharedPreferences.setString('lastName', uLastName);
    sharedPreferences.setString('email', uEmail);
    sharedPreferences.setString('mobile', uMobile);
    sharedPreferences.setString('photo', uProfilePic);
    sharedPreferences.setString('token', uToken);
    firstName = uFirstName;
    lastName = uLastName;
    email = uEmail;
    mobile = uMobile;
    profilePic = uProfilePic;
    token = uToken;
  }

  static Future<bool> checkLoginState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token == null) {
      return false;
    }
    return true;
  }

  static Future<void> getAuthDate() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    firstName = sharedPreferences.getString('firstName');
    lastName = sharedPreferences.getString('lastName');
    profilePic = sharedPreferences.getString('photo');
    mobile = sharedPreferences.getString('mobile');
  }

  static Future<void> clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
