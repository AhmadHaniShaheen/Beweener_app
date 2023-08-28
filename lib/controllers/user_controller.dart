
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/models/auth_model.dart';

Future<UserModel> getUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('user')) {
    return userModelFromJson(
      (prefs.getString("user")!),
    );
  } else {
    return Future.error('not Found');
  }
}
