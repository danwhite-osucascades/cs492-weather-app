import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PexelsImage {
  Future<String?> getImage(String prompt) async {
    final apiKey = dotenv.env['PEXELS_API_KEY'];
    if (apiKey == null) return null;

    final uri = Uri.parse(
      'https://api.pexels.com/v1/search?query=${Uri.encodeComponent(prompt)}&per_page=1',
    );

    final response = await http.get(
      uri,
      headers: {
        'Authorization': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['photos'] != null && data['photos'].isNotEmpty) {
        return data['photos'][0]['src']['large'];
      }
    }

    return null;
  }
}
