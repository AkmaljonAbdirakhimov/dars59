import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthHttpServices {
  Future<void> updatePassword() async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyDlqmnZB3Gf2z2ysupHwGBvGmfpnXRf_CM");

    final response = await http.post(
      url,
      body: jsonEncode(
        {
          "requestType": "PASSWORD_RESET",
          "email": "tobbyjefersn@gmail.com",
        },
      ),
    );

    print(response.body);
  }
}
