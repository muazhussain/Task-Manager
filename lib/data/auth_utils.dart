import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static String? token, email, firstName, lastName, mobile, photo;
  static Future<void> saveUserData(
      String userToken,
      String userEmail,
      String userFirstName,
      String userLastName,
      String userMobile,
      String userPhoto) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', userToken);
    sharedPreferences.setString('email', userEmail);
    sharedPreferences.setString('firstName', userFirstName);
    sharedPreferences.setString('lastName', userLastName);
    sharedPreferences.setString('mobile', userMobile);
    sharedPreferences.setString('photo', userPhoto);
    token = userToken;
    email = userEmail;
    firstName = userFirstName;
    lastName = userLastName;
    mobile = userMobile;
    photo = userPhoto;
  }

  static Future<bool> checkLoginState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> getAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    email = sharedPreferences.getString('email');
    firstName = sharedPreferences.getString('firstName');
    lastName = sharedPreferences.getString('lastName');
    mobile = sharedPreferences.getString('mobile');
    photo = sharedPreferences.getString('photo');
  }

  static Future<void> clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
