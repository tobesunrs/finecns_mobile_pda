import 'package:shared_preferences/shared_preferences.dart';

Future<String> userNameGet() async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();

  String userCode = _prefs?.getString('user_name') ?? '';
  return userCode;
}