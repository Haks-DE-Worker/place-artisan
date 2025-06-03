import 'package:shared_preferences/shared_preferences.dart';

//Here i will implement auth dunctions

//Function to get token
String getToken() {
  // Get the token from shared preferences
  return '';
}

Future<void> saveAgenceInfo() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', 'token');
}

Future<String?> getAgenceInfo() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Future<void> removeAgenceInfo() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}