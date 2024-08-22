import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lands_app/models/models.dart';
import 'constants.dart';

class ApiHelper {
//---------------------------------------------------------------------------
  static Future<Response> getLands() async {
    var url = Uri.parse('${Constants.apiUrl}/all');
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );
    var body = response.body;

    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: body);
    }

    List<Land> list = [];
    var decodedJson = jsonDecode(body);
    if (decodedJson != null) {
      for (var item in decodedJson) {
        list.add(Land.fromJson(item));
      }
    }
    return Response(isSuccess: true, result: list);
  }
}
