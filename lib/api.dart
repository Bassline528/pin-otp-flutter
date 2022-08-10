import 'package:http/http.dart' as http;

class Api {
  final String _url = 'http://192.168.0.9:8080/api';
  static Future httpGet() async {
    try {
      final resp = await http.get(Uri.parse('http://192.168.0.9:8080/api/otp'));
      return resp.body;
    } catch (e) {
      print(e);
    }
  }
}
