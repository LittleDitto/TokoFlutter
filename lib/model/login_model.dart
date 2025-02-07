class Login {
  int? code;
  bool? status;
  String? token;
  int? userID;
  String? userEmail;

  Login({this.code,this.status,this.token,this.userEmail,this.userID});

  factory Login.fromJson(Map<String, dynamic> obj) {
    return Login(
      code: obj['code'],
      status: obj['status'],
      token: obj['data']['token'],
      userID: obj['data']['user']['id'] != null
          ? int.tryParse(obj['data']['user']['id'].toString())
          : null,
      userEmail: obj['data']['user']['email'],
    );
  }

}