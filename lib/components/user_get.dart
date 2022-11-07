import 'package:shared_preferences/shared_preferences.dart';

Future<String> userGet() async {
final SharedPreferences _prefs = await SharedPreferences.getInstance();

  String userCode = _prefs?.getString('user_code') ?? '';
  return userCode;
}