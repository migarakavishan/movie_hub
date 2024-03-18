import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiServices {
  final endpoint = 'https://timeapi.io/api/Time/current/zone?timeZone=';

  Future<List<String>> getTime(String zone) async {
    List<String> values = [];
    final response = await http.get(Uri.parse('$endpoint$zone'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((key, value) {
        values.add("$key - $value");
      });
      return values;
    } else {
      Logger().e(response.statusCode);
      return ['Error - ${response.statusCode}'];
    }
  }
}
