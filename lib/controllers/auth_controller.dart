// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:tt9_betweener_challenge/models/auth_model.dart';

Future<UserModel> login(Map<String, String> body) async {
  var response = await http.post(
    Uri.parse('https://betweener.gsgtt.tech/api/login'),
    body: body,
  );

  if (response.statusCode == 200) {
    return userModelFromJson(response.body);
  } else {
    print('error');
    throw Exception('error to login');
  }
}
