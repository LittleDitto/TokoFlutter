import 'package:bflutter/helpers/user_info.dart';

class LogoutBloc{
  static Future logout() async {
  await UserInfo().logout();
  }
}
