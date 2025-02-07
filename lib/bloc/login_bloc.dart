import 'dart:convert';
import 'package:bflutter/helpers/api.dart';
import 'package:bflutter/model/login_model.dart';
import 'package:bflutter/helpers/api_url.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
  String apiUrl = ApiUrl.login;
  var body = {"email": email, "password": password};
  var response = await Api().post(apiUrl, body);
  var jsonObj = json.decode(response.body);
  return Login.fromJson(jsonObj);
  }
}
