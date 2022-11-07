import 'package:shared_preferences/shared_preferences.dart';

Future<String> ipGet() async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();

  String ip = _prefs?.getString('ip') ?? '';
  return ip;
}