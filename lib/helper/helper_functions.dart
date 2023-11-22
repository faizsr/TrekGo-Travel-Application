import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  // ====== USER PART ======

  // ===== Keys for user =====
  static String userLoggedInKey = 'USERLOGGEDINKEY';
  static String userFullNameKey = 'USERNAMEKEY';
  static String userEmailKey = 'USEREMAILKEY';
  static String userIdKey = 'USERIDKEY';

  // ===== Saving the user data to shared preference =====
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserFullName(String userFullname) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userFullNameKey, userFullname);
  }

  static Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  // ===== Getting the user data from shared preference =====
  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  // ====== ADMIN PART ======

  // ===== Keys for admin =====
  static String adminLoggedInKey = 'ADMINLOGGEDINKEY';
  static String adminIdKey = 'ADMINIDKEY';
  static String adminEmailkey = 'ADMINEMAILKEY';

  // ===== Saving the admiin data to shared preference =====
  static Future<bool> saveAdminLoggedInStatus(bool isAdminLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(adminLoggedInKey, isAdminLoggedIn);
  }

  static Future<bool> saveAdminId(String adminId) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(adminIdKey, adminId);
  }

  static Future<bool> saveAdminEmail(String adminEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(adminEmailkey, adminEmail);
  }

  // ===== Getting the data from shared preference
  static Future<bool?> getAdminLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(adminLoggedInKey);
  }
}
